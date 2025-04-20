const topicService = require('../services/topicService');
const { validationResult } = require('express-validator');

class TopicController {
	/**
	 * Tạo chủ đề mới
	 */
	async createTopic(req, res) {
		try {
			const errors = validationResult(req);
			if (!errors.isEmpty()) {
				return res.status(400).json({ errors: errors.array() });
			}

			const topic = await topicService.createTopic(req.body);
			res.status(201).json({
				success: true,
				data: topic
			});
		} catch (error) {
			res.status(500).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Cập nhật chủ đề
	 */
	async updateTopic(req, res) {
		try {
			const errors = validationResult(req);
			if (!errors.isEmpty()) {
				return res.status(400).json({ errors: errors.array() });
			}

			const topic = await topicService.updateTopic(req.params.id, req.body);
			res.json({
				success: true,
				data: topic
			});
		} catch (error) {
			res.status(500).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Xóa chủ đề
	 */
	async deleteTopic(req, res) {
		try {
			await topicService.deleteTopic(req.params.id);
			res.json({
				success: true,
				message: 'Topic deleted successfully'
			});
		} catch (error) {
			res.status(500).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Lấy danh sách chủ đề
	 */
	async getTopics(req, res) {
		try {
			const { page = 1, limit = 10, level } = req.query;
			const result = await topicService.getTopics(page, limit, level);
			res.json({
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
	 * Lấy danh sách chủ đề theo người dùng
	 */
	async getTopicsForMe(req, res) {
		try {
			const userId = req.user.id;
			const { page = 1, limit = 10 } = req.query;
			const result = await topicService.getTopicsForMe(userId, page, limit);
			res.json({
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
	 * Lấy chi tiết chủ đề
	 */
	async getTopicById(req, res) {
		try {
			const topic = await topicService.getTopicById(req.params.id);
			res.json({
				success: true,
				data: topic
			});
		} catch (error) {
			res.status(500).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Liệt kê các chủ đề dưới mức level hiện tại của user
	 */
	async getTopicsBelowLevel(req, res) {
		try {
			const userId = req.user.id; // Lấy từ token
			const { page = 1, limit = 10 } = req.query;

			const topics = await topicService.getTopicsBelowUserLevel(userId, page, limit);

			res.json({
				success: true,
				...topics
			});
		} catch (error) {
			res.status(500).json({
				success: false,
				message: error.message
			});
		}
	}
}

module.exports = new TopicController(); 