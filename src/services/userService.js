const { User, Vocabulary, UserVocabulary } = require('../models');
const { Sequelize, Op } = require('sequelize');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const { validationResult } = require('express-validator');
const Joi = require('joi');

// Validation schema
const userSchema = Joi.object({
	name: Joi.string().required().max(255).trim(),
	age: Joi.number().required().min(0),
	username: Joi.string().required().max(255).trim(),
	password: Joi.string().required().min(6).trim(),
	role: Joi.string().valid('admin', 'learner').default('learner'),
	level: Joi.string().valid('beginner', 'elementary', 'intermediate', 'advanced', 'expert').allow(null)
});

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
			level: (role ?? 'learner') === 'learner' ? (level || 'beginner') : null
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

	/**
	 * Lấy danh sách người học với tìm kiếm và lọc theo level
	 */
	async getLearners(page = 1, limit = 10, search = '', level = null) {
		try {
			// Validate level
			const validLevels = ['beginner', 'elementary', 'intermediate', 'advanced', 'expert'];
			if (level && !validLevels.includes(level)) {
				throw new Error(`Invalid level. Must be one of: ${validLevels.join(', ')}`);
			}

			const offset = (page - 1) * limit;
			const whereClause = {
				role: 'learner'
			};

			// Tìm kiếm theo tên hoặc username
			if (search) {
				whereClause[Op.or] = [
					{ name: { [Op.like]: `%${search}%` } },
					{ username: { [Op.like]: `%${search}%` } }
				];
			}

			// Lọc theo level
			if (level) {
				whereClause.level = level;
			}

			const { count, rows } = await User.findAndCountAll({
				where: whereClause,
				limit: parseInt(limit),
				offset: parseInt(offset),
				order: [['createdAt', 'DESC']],
				attributes: ['id', 'name', 'username', 'role', 'level', 'createdAt', 'updatedAt']
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
			throw new Error(`Error fetching learners: ${error.message}`);
		}
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

	/**
	 * Lấy danh sách từ vựng đã học và chưa học của người dùng
	 */
	async getUserVocabularies(userId, isLearned = null, page = 1, limit = 10, topicId = null) {
		try {
			const user = await User.findByPk(userId);
			if (!user) throw new Error('User not found');

			const offset = (page - 1) * limit;
			const whereClause = {};
			if (user.level) whereClause.level = user.level;
			if (topicId) whereClause.topicId = topicId; 
			const pagination = {
				limit: parseInt(limit),
				offset: parseInt(offset),
				order: [['createdAt', 'DESC']],
			};

			// Case 1: isLearned === true (đã học)
			if (isLearned === true || isLearned === 'true') {
				const { count, rows } = await Vocabulary.findAndCountAll({
					where: whereClause,
					include: [{
						model: User,
						where: { id: userId },
						through: { attributes: [] }, // bỏ dữ liệu từ bảng trung gian
						attributes: [], // không cần dữ liệu từ User
						required: true
					}],
					...pagination,
				});

				return {
					data: rows.map(vocab => ({ ...vocab.toJSON(), isLearned: true })),
					pagination: {
						total: count,
						page: parseInt(page),
						limit: parseInt(limit),
						pages: Math.ceil(count / limit),
					},
				};
			}

			// Case 2: isLearned === false (chưa học)
			if (isLearned === false || isLearned === 'false') {
				const learnedSubQuery = UserVocabulary.findAll({
					where: { userId },
					attributes: ['vocabularyId'],
					raw: true,
				});
				const excludeIds = (await learnedSubQuery).map(item => item.vocabularyId);

				const unlearnedWhere = { ...whereClause };
				if (excludeIds.length > 0) {
					unlearnedWhere.id = { [Op.notIn]: excludeIds };
				}

				const { count, rows } = await Vocabulary.findAndCountAll({
					where: unlearnedWhere,
					...pagination,
				});

				return {
					data: rows.map(vocab => ({ ...vocab.toJSON(), isLearned: false })),
					pagination: {
						total: count,
						page: parseInt(page),
						limit: parseInt(limit),
						pages: Math.ceil(count / limit),
					},
				};
			}

			// Case 3: isLearned === null (tất cả)
			const [allVocab, learnedVocabs] = await Promise.all([
				Vocabulary.findAndCountAll({
					where: whereClause,
					...pagination,
				}),
				UserVocabulary.findAll({
					where: { userId },
					attributes: ['vocabularyId'],
					raw: true,
				}),
			]);

			const learnedSet = new Set(learnedVocabs.map(uv => uv.vocabularyId));

			return {
				data: allVocab.rows.map(vocab => ({
					...vocab.toJSON(),
					isLearned: learnedSet.has(vocab.id),
				})),
				pagination: {
					total: allVocab.count,
					page: parseInt(page),
					limit: parseInt(limit),
					pages: Math.ceil(allVocab.count / limit),
				},
			};
		} catch (error) {
			throw new Error(`Error fetching user vocabularies: ${error.message}`);
		}
	}


	/**
	 * Đánh dấu từ vựng đã học
	 */
	async markVocabularyAsLearned(userId, vocabularyId) {
		try {
			// Kiểm tra xem từ vựng đã tồn tại chưa
			const existingRecord = await UserVocabulary.findOne({
				where: { userId, vocabularyId }
			});

			if (!existingRecord) {
				await UserVocabulary.create({
					userId,
					vocabularyId
				});
			}

			return true;
		} catch (error) {
			throw new Error(`Error marking vocabulary as learned: ${error.message}`);
		}
	}

	/**
	 * Đánh dấu từ vựng chưa học (xóa khỏi danh sách đã học)
	 */
	async markVocabularyAsUnlearned(userId, vocabularyId) {
		try {
			const result = await UserVocabulary.destroy({
				where: { userId, vocabularyId }
			});

			if (result === 0) {
				throw new Error('Vocabulary not found in learned list');
			}

			return true;
		} catch (error) {
			throw new Error(`Error marking vocabulary as unlearned: ${error.message}`);
		}
	}
}

module.exports = new UserService(); 