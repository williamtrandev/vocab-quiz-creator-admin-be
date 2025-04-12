const { User } = require('../models');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { validationResult } = require('express-validator');

class UserService {
	// Đăng ký người dùng mới
	async register(userData) {
		const { name, age, username, password, role, level } = userData;

		// Kiểm tra username đã tồn tại chưa
		const existingUser = await User.findOne({ where: { username } });
		if (existingUser) {
			throw new Error('Username already exists');
		}

		// Mã hóa password
		const hashedPassword = await bcrypt.hash(password, 10);

		// Tạo user mới
		const user = await User.create({
			name,
			age,
			username,
			password: hashedPassword,
			role: role || 'learner',
			level: role === 'learner' ? level : null
		});

		// Tạo token
		const token = jwt.sign(
			{ id: user.id, role: user.role },
			process.env.JWT_SECRET,
			{ expiresIn: '24h' }
		);

		return {
			user: {
				id: user.id,
				name: user.name,
				username: user.username,
				role: user.role,
				level: user.level
			},
			token
		};
	}

	// Đăng nhập
	async login(loginData) {
		const { username, password } = loginData;

		// Tìm user theo username
		const user = await User.findOne({ where: { username } });
		if (!user) {
			throw new Error('Invalid username or password');
		}

		// Kiểm tra password
		const isPasswordValid = await bcrypt.compare(password, user.password);
		if (!isPasswordValid) {
			throw new Error('Invalid username or password');
		}

		// Tạo token
		const token = jwt.sign(
			{ id: user.id, role: user.role },
			process.env.JWT_SECRET,
			{ expiresIn: '24h' }
		);

		return {
			user: {
				id: user.id,
				name: user.name,
				username: user.username,
				role: user.role,
				level: user.level
			},
			token
		};
	}

	// Lấy danh sách người học
	async getLearners() {
		const learners = await User.findAll({
			where: { role: 'learner' },
			attributes: ['id', 'name', 'age', 'username', 'level', 'createdAt']
		});
		return learners;
	}

	// Cập nhật thông tin người dùng
	async updateUser(userId, updateData) {
		const { name, age, level } = updateData;

		const user = await User.findByPk(userId);
		if (!user) {
			throw new Error('User not found');
		}

		// Cập nhật thông tin
		await user.update({
			name: name || user.name,
			age: age || user.age,
			level: level || user.level
		});

		return {
			id: user.id,
			name: user.name,
			age: user.age,
			username: user.username,
			role: user.role,
			level: user.level
		};
	}
}

module.exports = new UserService(); 