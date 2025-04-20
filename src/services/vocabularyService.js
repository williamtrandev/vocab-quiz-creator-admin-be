const { Vocabulary, Topic } = require('../models');
const { Op } = require('sequelize');
const Joi = require('joi');

// Validation schema
const vocabularySchema = Joi.object({
	word: Joi.string().required().max(255).trim(),
	meaning: Joi.string().required().trim(),
	example: Joi.string().allow('', null).trim(),
	level: Joi.string().required().valid('beginner', 'elementary', 'intermediate', 'advanced', 'expert')
});

class VocabularyService {
	/**
	 * Lấy tất cả từ vựng
	 */
	async getAllVocabularies(page = 1, limit = 10, level = null, topicId = null) {
		try {
			const offset = (page - 1) * limit;
			const queryOptions = {
				limit: parseInt(limit),
				offset: parseInt(offset),
				order: [['createdAt', 'DESC']]
			};

			if (level) {
				queryOptions.where = { level };
			}

			if (topicId) {
				queryOptions.where = { topicId };
			}

			const { count, rows } = await Vocabulary.findAndCountAll({
				...queryOptions,
				include: [
					{
						model: Topic,
						as: 'topic',
						attributes: ['id', 'name', 'description'], 
						required: false
					}
				]
			});

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
			throw new Error(`Error fetching vocabularies: ${error.message}`);
		}
	}

	/**
	 * Lấy từ vựng theo ID
	 */
	async getVocabularyById(id) {
		try {
			const vocabulary = await Vocabulary.findByPk(id);
			if (!vocabulary) {
				throw new Error('Vocabulary not found');
			}
			return vocabulary;
		} catch (error) {
			throw error;
		}
	}

	/**
	 * Tìm kiếm từ vựng
	 */
	async searchVocabulary(keyword, level = null) {
		try {
			const whereClause = {
				word: {
					[Op.like]: `%${keyword}%`
				}
			};

			if (level) {
				whereClause.level = level;
			}

			const vocabularies = await Vocabulary.findAll({
				where: whereClause,
				order: [['createdAt', 'DESC']]
			});

			return vocabularies;
		} catch (error) {
			throw new Error(`Error searching vocabularies: ${error.message}`);
		}
	}

	/**
	 * Tạo từ vựng mới
	 */
	async createVocabulary(vocabularyData) {
		try {
			// Kiểm tra topic nếu có
			if (vocabularyData.topicId) {
				const topic = await Topic.findByPk(vocabularyData.topicId);
				if (!topic) {
					throw new Error('Topic not found');
				}

				// Kiểm tra level của topic và từ vựng
				if (topic.level !== vocabularyData.level) {
					throw new Error('Vocabulary level must match topic level');
				}
			}

			const vocabulary = await Vocabulary.create(vocabularyData);
			return vocabulary;
		} catch (error) {
			throw new Error(`Error creating vocabulary: ${error.message}`);
		}
	}

	/**
	 * Cập nhật từ vựng
	 */
	async updateVocabulary(id, vocabularyData) {
		try {
			const vocabulary = await Vocabulary.findByPk(id);
			if (!vocabulary) {
				throw new Error('Vocabulary not found');
			}

			// Kiểm tra topic nếu có thay đổi
			if (vocabularyData.topicId !== undefined) {
				if (vocabularyData.topicId === null) {
					// Cho phép set topicId = null
					vocabularyData.topicId = null;
				} else {
					const topic = await Topic.findByPk(vocabularyData.topicId);
					if (!topic) {
						throw new Error('Topic not found');
					}

					// Kiểm tra level của topic và từ vựng
					if (topic.level !== vocabularyData.level) {
						throw new Error('Vocabulary level must match topic level');
					}
				}
			}

			await vocabulary.update(vocabularyData);
			return vocabulary;
		} catch (error) {
			throw new Error(`Error updating vocabulary: ${error.message}`);
		}
	}

	/**
	 * Xóa từ vựng
	 */
	async deleteVocabulary(id) {
		try {
			const vocabulary = await Vocabulary.findByPk(id);
			if (!vocabulary) {
				throw new Error('Vocabulary not found');
			}

			await vocabulary.destroy();
			return true;
		} catch (error) {
			throw new Error(`Error deleting vocabulary: ${error.message}`);
		}
	}

	/**
	 * Lấy từ vựng theo level
	 */
	async getVocabulariesByLevel(level) {
		try {
			if (!['beginner', 'elementary', 'intermediate', 'advanced', 'expert'].includes(level)) {
				throw new Error('Invalid level');
			}

			const vocabularies = await Vocabulary.findAll({
				where: { level },
				order: [['createdAt', 'DESC']]
			});

			return vocabularies;
		} catch (error) {
			throw error;
		}
	}
}

module.exports = new VocabularyService();