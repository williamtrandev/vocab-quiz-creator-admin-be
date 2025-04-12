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
		// Kiểm tra quyền admin
		if (req.user.role !== 'admin') {
			return res.status(403).json({ message: 'Access denied' });
		}

		const learners = await userService.getLearners();
		res.json(learners);
	} catch (error) {
		res.status(500).json({ message: error.message });
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