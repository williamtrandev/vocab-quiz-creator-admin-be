const QuestionSetService = require('../services/questionSetService');

class QuestionSetController {
	/**
	 * Lấy tất cả Question Sets với phân trang
	 */
	async getAllQuestionSets(req, res) {
		try {
			const { page = 1, limit = 10, level } = req.query;
			const result = await QuestionSetService.getAllQuestionSets(page, limit, level);

			res.status(200).json({
				success: true,
				...result
			});
		} catch (error) {
			res.status(500).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Lấy Question Set theo ID
	 */
	async getQuestionSetById(req, res) {
		try {
			const { id } = req.params;
			const questionSet = await QuestionSetService.getQuestionSetById(id);

			res.status(200).json({
				success: true,
				data: questionSet
			});
		} catch (error) {
			const statusCode = error.message === 'Question set not found' ? 404 : 500;
			res.status(statusCode).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Tạo Question Set mới
	 */
	async createQuestionSet(req, res) {
		try {
			const questionSet = await QuestionSetService.createQuestionSet(req.body);

			res.status(201).json({
				success: true,
				message: 'Question set created successfully',
				data: questionSet
			});
		} catch (error) {
			const statusCode = error.message.includes('Validation error') ? 400 : 500;
			res.status(statusCode).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Cập nhật Question Set
	 */
	async updateQuestionSet(req, res) {
		try {
			const { id } = req.params;
			const questionSet = await QuestionSetService.updateQuestionSet(id, req.body);

			res.status(200).json({
				success: true,
				message: 'Question set updated successfully',
				data: questionSet
			});
		} catch (error) {
			let statusCode = 500;
			if (error.message.includes('Validation error')) {
				statusCode = 400;
			} else if (error.message === 'Question set not found') {
				statusCode = 404;
			}

			res.status(statusCode).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Xóa Question Set
	 */
	async deleteQuestionSet(req, res) {
		try {
			const { id } = req.params;
			await QuestionSetService.deleteQuestionSet(id);

			res.status(200).json({
				success: true,
				message: 'Question set deleted successfully'
			});
		} catch (error) {
			const statusCode = error.message === 'Question set not found' ? 404 : 500;
			res.status(statusCode).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Thêm từ vựng vào Question Set
	 */
	async addVocabularyToQuestionSet(req, res) {
		try {
			const { id } = req.params;
			const { vocabularyId } = req.body;

			if (!vocabularyId) {
				return res.status(400).json({
					success: false,
					message: 'Vocabulary ID is required'
				});
			}

			const result = await QuestionSetService.addVocabularyToQuestionSet(id, vocabularyId);

			if (result.alreadyExists) {
				return res.status(200).json({
					success: true,
					message: 'Vocabulary is already in this question set'
				});
			}

			res.status(201).json({
				success: true,
				message: 'Vocabulary added to question set successfully'
			});
		} catch (error) {
			let statusCode = 500;

			if (error.message === 'Question set not found' || error.message === 'Vocabulary not found') {
				statusCode = 404;
			} else if (error.message.includes('Cannot add a vocabulary with level')) {
				statusCode = 400;
			}

			res.status(statusCode).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Xóa từ vựng khỏi Question Set
	 */
	async removeVocabularyFromQuestionSet(req, res) {
		try {
			const { id, vocabularyId } = req.params;

			await QuestionSetService.removeVocabularyFromQuestionSet(id, vocabularyId);

			res.status(200).json({
				success: true,
				message: 'Vocabulary removed from question set successfully'
			});
		} catch (error) {
			let statusCode = 500;

			if (error.message === 'Question set not found' || error.message === 'Vocabulary not found' || error.message === 'Vocabulary is not in this question set') {
				statusCode = 404;
			}

			res.status(statusCode).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Lấy danh sách từ vựng trong một Question Set
	 */
	async getVocabulariesInQuestionSet(req, res) {
		try {
			const { id } = req.params;
			const vocabularies = await QuestionSetService.getVocabulariesInQuestionSet(id);

			res.status(200).json({
				success: true,
				data: vocabularies
			});
		} catch (error) {
			const statusCode = error.message === 'Question set not found' ? 404 : 500;
			res.status(statusCode).json({
				success: false,
				message: error.message
			});
		}
	}
}

module.exports = new QuestionSetController();