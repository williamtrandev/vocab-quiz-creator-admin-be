const VocabularyService = require('../services/vocabularyService');

class VocabularyController {
	/**
	 * Lấy tất cả từ vựng với phân trang
	 */
	async getAllVocabularies(req, res) {
		try {
			const { page = 1, limit = 10, level } = req.query;
			const result = await VocabularyService.getAllVocabularies(page, limit, level);

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
	 * Lấy từ vựng theo ID
	 */
	async getVocabularyById(req, res) {
		try {
			const { id } = req.params;
			const vocabulary = await VocabularyService.getVocabularyById(id);

			res.status(200).json({
				success: true,
				data: vocabulary
			});
		} catch (error) {
			const statusCode = error.message === 'Vocabulary not found' ? 404 : 500;
			res.status(statusCode).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Tìm kiếm từ vựng
	 */
	async searchVocabulary(req, res) {
		try {
			const { keyword, level } = req.query;

			if (!keyword) {
				return res.status(400).json({
					success: false,
					message: 'Keyword is required for search'
				});
			}

			const result = await VocabularyService.searchVocabulary(keyword, level);

			res.status(200).json({
				success: true,
				data: result
			});
		} catch (error) {
			res.status(500).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Tạo từ vựng mới
	 */
	async createVocabulary(req, res) {
		try {
			const vocabulary = await VocabularyService.createVocabulary(req.body);

			res.status(201).json({
				success: true,
				message: 'Vocabulary created successfully',
				data: vocabulary
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
	 * Cập nhật từ vựng
	 */
	async updateVocabulary(req, res) {
		try {
			const { id } = req.params;
			const vocabulary = await VocabularyService.updateVocabulary(id, req.body);

			res.status(200).json({
				success: true,
				message: 'Vocabulary updated successfully',
				data: vocabulary
			});
		} catch (error) {
			let statusCode = 500;
			if (error.message.includes('Validation error')) {
				statusCode = 400;
			} else if (error.message === 'Vocabulary not found') {
				statusCode = 404;
			}

			res.status(statusCode).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Xóa từ vựng
	 */
	async deleteVocabulary(req, res) {
		try {
			const { id } = req.params;
			await VocabularyService.deleteVocabulary(id);

			res.status(200).json({
				success: true,
				message: 'Vocabulary deleted successfully'
			});
		} catch (error) {
			const statusCode = error.message === 'Vocabulary not found' ? 404 : 500;
			res.status(statusCode).json({
				success: false,
				message: error.message
			});
		}
	}
}

module.exports = new VocabularyController();