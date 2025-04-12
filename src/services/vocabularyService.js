const { Vocabulary } = require('../models');
const { Op } = require('sequelize');
const Joi = require('joi');

// Validation schema
const vocabularySchema = Joi.object({
	word: Joi.string().required().max(255).trim(),
	meaning: Joi.string().required().trim(),
	level: Joi.string().required().valid('beginner', 'elementary', 'intermediate', 'advanced', 'expert')
});

class VocabularyService {
	/**
	 * Lấy tất cả từ vựng
	 */
	async getAllVocabularies(page = 1, limit = 10, level = null) {
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

			const { count, rows } = await Vocabulary.findAndCountAll(queryOptions);

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
			// Validate data
			const { error, value } = vocabularySchema.validate(vocabularyData);
			if (error) {
				throw new Error(`Validation error: ${error.details[0].message}`);
			}

			const vocabulary = await Vocabulary.create(value);
			return vocabulary;
		} catch (error) {
			throw error;
		}
	}

	/**
	 * Cập nhật từ vựng
	 */
	async updateVocabulary(id, vocabularyData) {
		try {
			// Validate data
			const { error, value } = vocabularySchema.validate(vocabularyData);
			if (error) {
				throw new Error(`Validation error: ${error.details[0].message}`);
			}

			// Kiểm tra xem từ vựng có tồn tại không
			const vocabulary = await Vocabulary.findByPk(id);
			if (!vocabulary) {
				throw new Error('Vocabulary not found');
			}

			await vocabulary.update(value);
			return vocabulary;
		} catch (error) {
			throw error;
		}
	}

	/**
	 * Xóa từ vựng
	 */
	async deleteVocabulary(id) {
		try {
			// Kiểm tra xem từ vựng có tồn tại không
			const vocabulary = await Vocabulary.findByPk(id);
			if (!vocabulary) {
				throw new Error('Vocabulary not found');
			}

			await vocabulary.destroy();
			return { success: true };
		} catch (error) {
			throw error;
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