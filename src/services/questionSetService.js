const { QuestionSet, Vocabulary, Question } = require('../models');
const { Op } = require('sequelize');
const Joi = require('joi');

// Validation schema cho câu hỏi
const questionSchema = Joi.object({
	vocabularyId: Joi.number().required(),
	correctAnswer: Joi.string().required().max(255),
	wrongAnswer1: Joi.string().required().max(255),
	wrongAnswer2: Joi.string().required().max(255),
	wrongAnswer3: Joi.string().required().max(255)
});

// Validation schema cho question set
const questionSetSchema = Joi.object({
	name: Joi.string().required().max(255).trim(),
	description: Joi.string().allow('', null),
	level: Joi.string().required().valid('beginner', 'elementary', 'intermediate', 'advanced', 'expert'),
	questions: Joi.array().items(questionSchema).min(1).required()
});

class QuestionSetService {
	/**
	 * Tạo Question Set mới với danh sách câu hỏi
	 */
	async createQuestionSet(questionSetData) {
		try {
			// Validate dữ liệu
			const { error } = questionSetSchema.validate(questionSetData);
			if (error) {
				throw new Error(error.details[0].message);
			}

			// Kiểm tra xem tất cả vocabulary có tồn tại không
			const vocabularyIds = questionSetData.questions.map(q => q.vocabularyId);
			const vocabularies = await Vocabulary.findAll({
				where: {
					id: {
						[Op.in]: vocabularyIds
					}
				}
			});

			if (vocabularies.length !== vocabularyIds.length) {
				throw new Error('One or more vocabularies not found');
			}

			// Tạo question set
			const questionSet = await QuestionSet.create({
				name: questionSetData.name,
				description: questionSetData.description,
				level: questionSetData.level,
				totalQuestions: questionSetData.questions.length
			});

			// Tạo các câu hỏi
			const questions = await Promise.all(
				questionSetData.questions.map(question =>
					Question.create({
						...question,
						questionSetId: questionSet.id
					})
				)
			);

			return {
				...questionSet.toJSON(),
				questions
			};
		} catch (error) {
			throw new Error(`Error creating question set: ${error.message}`);
		}
	}

	/**
	 * Lấy tất cả Question Sets
	 */
	async getAllQuestionSets(page = 1, limit = 10, level = null) {
		try {
			const offset = (page - 1) * limit;
			const queryOptions = {
				limit: parseInt(limit),
				offset: parseInt(offset),
				order: [['createdAt', 'DESC']],
				include: [
					{
						model: Question,
						as: 'questions',
						attributes: { exclude: ['vocabularyId', 'questionSetId', 'createdAt', 'updatedAt'] },
						include: [
							{
								model: Vocabulary,
								as: 'vocabulary',
								attributes: ['id', 'word', 'meaning']
							}
						]
					}
				]
			};

			if (level) {
				queryOptions.where = { level };
			}

			const { count, rows } = await QuestionSet.findAndCountAll(queryOptions);

			return {
				data: rows,
				pagination: {
					total: count,
					page: parseInt(page),
					limit: parseInt(limit),
					pages: Math.ceil(count / limit)
				}
			};
		} catch (error) {
			throw new Error(`Error fetching question sets: ${error.message}`);
		}
	}

	/**
	 * Lấy Question Set theo ID
	 */
	async getQuestionSetById(id) {
		try {
			const questionSet = await QuestionSet.findByPk(id, {
				include: [
					{
						model: Question,
						as: 'questions',
						attributes: { exclude: ['vocabularyId', 'questionSetId', 'createdAt', 'updatedAt'] },
						include: [
							{
								model: Vocabulary,
								as: 'vocabulary',
								attributes: ['id', 'word', 'meaning']
							}
						]
					}
				]
			});

			if (!questionSet) {
				throw new Error('Question set not found');
			}

			return questionSet;
		} catch (error) {
			throw new Error(`Error fetching question set: ${error.message}`);
		}
	}

	/**
	 * Cập nhật Question Set
	 */
	async updateQuestionSet(id, questionSetData) {
		try {
			const questionSet = await QuestionSet.findByPk(id);
			if (!questionSet) {
				throw new Error('Question set not found');
			}

			await questionSet.update(questionSetData);
			return questionSet;
		} catch (error) {
			throw new Error(`Error updating question set: ${error.message}`);
		}
	}

	/**
	 * Xóa Question Set
	 */
	async deleteQuestionSet(id) {
		try {
			const questionSet = await QuestionSet.findByPk(id);
			if (!questionSet) {
				throw new Error('Question set not found');
			}

			await questionSet.destroy();
			return true;
		} catch (error) {
			throw new Error(`Error deleting question set: ${error.message}`);
		}
	}

	/**
	 * Thêm từ vựng vào Question Set
	 */
	async addVocabularyToQuestionSet(questionSetId, vocabularyId) {
		try {
			// Kiểm tra xem question set và vocabulary có tồn tại không
			const questionSet = await QuestionSet.findByPk(questionSetId);
			if (!questionSet) {
				throw new Error('Question set not found');
			}

			const vocabulary = await Vocabulary.findByPk(vocabularyId);
			if (!vocabulary) {
				throw new Error('Vocabulary not found');
			}

			// Kiểm tra level của vocabulary và question set
			if (vocabulary.level !== questionSet.level) {
				throw new Error(`Cannot add a vocabulary with level "${vocabulary.level}" to a question set with level "${questionSet.level}"`);
			}

			// Kiểm tra xem từ vựng đã có trong question set chưa
			const hasVocabulary = await questionSet.hasVocabulary(vocabulary);
			if (hasVocabulary) {
				return { alreadyExists: true };
			}

			await questionSet.addVocabulary(vocabulary);
			return { success: true };
		} catch (error) {
			throw error;
		}
	}

	/**
	 * Xóa từ vựng khỏi Question Set
	 */
	async removeVocabularyFromQuestionSet(questionSetId, vocabularyId) {
		try {
			// Kiểm tra xem question set và vocabulary có tồn tại không
			const questionSet = await QuestionSet.findByPk(questionSetId);
			if (!questionSet) {
				throw new Error('Question set not found');
			}

			const vocabulary = await Vocabulary.findByPk(vocabularyId);
			if (!vocabulary) {
				throw new Error('Vocabulary not found');
			}

			// Kiểm tra xem từ vựng có trong question set không
			const hasVocabulary = await questionSet.hasVocabulary(vocabulary);
			if (!hasVocabulary) {
				throw new Error('Vocabulary is not in this question set');
			}

			await questionSet.removeVocabulary(vocabulary);
			return { success: true };
		} catch (error) {
			throw error;
		}
	}

	/**
	 * Lấy danh sách từ vựng trong một Question Set
	 */
	async getVocabulariesInQuestionSet(questionSetId) {
		try {
			const questionSet = await QuestionSet.findByPk(questionSetId, {
				include: [{
					model: Vocabulary,
					through: { attributes: [] } // loại bỏ thuộc tính của bảng trung gian
				}]
			});

			if (!questionSet) {
				throw new Error('Question set not found');
			}

			return questionSet.Vocabularies;
		} catch (error) {
			throw error;
		}
	}
}

module.exports = new QuestionSetService();