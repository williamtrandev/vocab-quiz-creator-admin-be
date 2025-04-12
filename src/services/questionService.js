const { Question, Vocabulary, QuestionSet } = require('../models');
const Joi = require('joi');

// Validation schema
const questionSchema = Joi.object({
	questionSetId: Joi.number().required(),
	vocabularyId: Joi.number().required(),
	correctAnswer: Joi.string().required().max(255),
	wrongAnswer1: Joi.string().required().max(255),
	wrongAnswer2: Joi.string().required().max(255),
	wrongAnswer3: Joi.string().required().max(255)
});

class QuestionService {
	/**
	 * Tạo câu hỏi mới
	 */
	async createQuestion(questionData) {
		try {
			// Validate dữ liệu
			const { error } = questionSchema.validate(questionData);
			if (error) {
				throw new Error(error.details[0].message);
			}

			// Kiểm tra xem vocabulary có tồn tại không
			const vocabulary = await Vocabulary.findByPk(questionData.vocabularyId);
			if (!vocabulary) {
				throw new Error('Vocabulary not found');
			}

			// Kiểm tra xem question set có tồn tại không
			const questionSet = await QuestionSet.findByPk(questionData.questionSetId);
			if (!questionSet) {
				throw new Error('Question set not found');
			}

			// Tạo câu hỏi
			const question = await Question.create(questionData);

			// Cập nhật tổng số câu hỏi trong question set
			await questionSet.increment('totalQuestions');

			return question;
		} catch (error) {
			throw new Error(`Error creating question: ${error.message}`);
		}
	}

	/**
	 * Lấy tất cả câu hỏi của một question set
	 */
	async getQuestionsByQuestionSetId(questionSetId) {
		try {
			const questions = await Question.findAll({
				where: { questionSetId },
				attributes: { exclude: ['vocabularyId', 'questionSetId'] },
				include: [
					{
						model: Vocabulary,
						as: 'vocabulary',
						attributes: ['id', 'word', 'meaning']
					}
				]
			});

			return questions;
		} catch (error) {
			throw new Error(`Error fetching questions: ${error.message}`);
		}
	}

	/**
	 * Xóa câu hỏi
	 */
	async deleteQuestion(id) {
		try {
			const question = await Question.findByPk(id);
			if (!question) {
				throw new Error('Question not found');
			}

			const questionSet = await QuestionSet.findByPk(question.questionSetId);
			await question.destroy();
			await questionSet.decrement('totalQuestions');

			return true;
		} catch (error) {
			throw new Error(`Error deleting question: ${error.message}`);
		}
	}
}

module.exports = new QuestionService(); 