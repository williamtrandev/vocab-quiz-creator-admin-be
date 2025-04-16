const userService = require('../services/userService');
const { validationResult } = require('express-validator');

// Đăng ký người dùng mới
exports.register = async (req, res) => {
	try {
		const errors = validationResult(req);
		if (!errors.isEmpty()) {
			return res.status(400).json({ errors: errors.array() });
		}

		const result = await userService.register(req.body);
		res.status(201).json({
			message: 'User registered successfully',
			...result
		});
	} catch (error) {
		res.status(400).json({ message: error.message });
	}
};

// Đăng nhập
exports.login = async (req, res) => {
	try {
		const errors = validationResult(req);
		if (!errors.isEmpty()) {
			return res.status(400).json({ errors: errors.array() });
		}

		const result = await userService.login(req.body);
		res.json({
			message: 'Login successful',
			...result
		});
	} catch (error) {
		res.status(401).json({ message: error.message });
	}
};

// Lấy danh sách người học (chỉ admin)
exports.getLearners = async (req, res) => {
	try {
		const { page = 1, limit = 10, search = '', level } = req.query;

		// Validate parameters
		if (isNaN(page) || isNaN(limit) || page < 1 || limit < 1) {
			return res.status(400).json({
				success: false,
				message: 'Invalid page or limit parameters'
			});
		}

		const result = await userService.getLearners(
			parseInt(page),
			parseInt(limit),
			search,
			level
		);

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
};

// Cập nhật thông tin người dùng
exports.updateUser = async (req, res) => {
	try {
		const { id } = req.params;

		// Kiểm tra quyền
		if (req.user.role !== 'admin' && req.user.id !== parseInt(id)) {
			return res.status(403).json({ message: 'Access denied' });
		}

		const updatedUser = await userService.updateUser(id, req.body);
		res.json({
			message: 'User updated successfully',
			user: updatedUser
		});
	} catch (error) {
		res.status(400).json({ message: error.message });
	}
};

/**
 * Lấy danh sách người học với tìm kiếm và lọc theo level
 */
exports.getLearnersWithSearchAndFilter = async (req, res) => {
	try {
		const { page = 1, limit = 10, search = '', level } = req.query;
		const result = await userService.getLearners(page, limit, search, level);

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
};

/**
 * Lấy danh sách từ vựng đã học và chưa học của người dùng
 */
exports.getUserVocabularies = async (req, res) => {
	try {
		const userId = req.user.id;
		const { isLearned, page = 1, limit = 10, topicId } = req.query;

		// Validate parameters
		if (isNaN(page) || isNaN(limit) || page < 1 || limit < 1) {
			return res.status(400).json({
				success: false,
				message: 'Invalid page or limit parameters'
			});
		}

		const result = await userService.getUserVocabularies(
			userId,
			isLearned,
			parseInt(page),
			parseInt(limit),
			topicId
		);

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
};

/**
 * Đánh dấu từ vựng đã học
 */
exports.markVocabularyAsLearned = async (req, res) => {
	try {
		const userId = req.user.id;
		const { vocabularyId } = req.params;
		const result = await userService.markVocabularyAsLearned(userId, vocabularyId);
		res.status(200).json({
			success: result
		});
	} catch (error) {
		res.status(500).json({ success: false, message: error.message });
	}
};

/**
 * Đánh dấu từ vựng chưa học
 */
exports.markVocabularyAsUnlearned = async (req, res) => {
	try {
		const userId = req.user.id;
		const { vocabularyId } = req.params;
		const result = await userService.markVocabularyAsUnlearned(userId, vocabularyId);
		res.status(200).json({
			success: result
		});
	} catch (error) {
		res.status(500).json({ success: false, message: error.message });
	}
}; 