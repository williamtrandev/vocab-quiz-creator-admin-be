const { User, Topic, Vocabulary } = require('../models');
const { Sequelize, Op } = require('sequelize');

class TopicService {
	/**
	 * Tạo chủ đề mới
	 */
	async createTopic(topicData) {
		try {
			const topic = await Topic.create(topicData);
			return topic;
		} catch (error) {
			throw new Error(`Error creating topic: ${error.message}`);
		}
	}

	/**
	 * Cập nhật chủ đề
	 */
	async updateTopic(id, topicData) {
		try {
			const topic = await Topic.findByPk(id);
			if (!topic) {
				throw new Error('Topic not found');
			}

			// Kiểm tra nếu có thay đổi level
			if (topicData.level && topicData.level !== topic.level) {
				// Đếm số từ vựng có level khác với level mới
				const vocabularyCount = await Vocabulary.count({
					where: {
						topicId: id,
						level: { [Op.ne]: topicData.level }
					}
				});

				if (vocabularyCount > 0) {
					throw new Error('Cannot update topic level because there are vocabularies with different levels');
				}
			}

			await topic.update(topicData);
			return topic;
		} catch (error) {
			throw new Error(`Error updating topic: ${error.message}`);
		}
	}

	/**
	 * Xóa chủ đề
	 */
	async deleteTopic(id) {
		try {
			const topic = await Topic.findByPk(id);
			if (!topic) {
				throw new Error('Topic not found');
			}

			// Cập nhật topicId của các từ vựng thuộc chủ đề này thành null
			await Vocabulary.update(
				{ topicId: null },
				{ where: { topicId: id } }
			);

			await topic.destroy();
			return true;
		} catch (error) {
			throw new Error(`Error deleting topic: ${error.message}`);
		}
	}

	/**
	 * Lấy danh sách chủ đề
	 */
	async getTopics(page = 1, limit = 10, level = null) {
		try {
			const offset = (page - 1) * limit;
			const whereClause = {};

			if (level) {
				whereClause.level = level;
			}

			const { count, rows } = await Topic.findAndCountAll({
				where: whereClause,
				limit: parseInt(limit),
				offset: parseInt(offset),
				order: [['createdAt', 'DESC']],
				include: [{
					model: Vocabulary,
					as: 'vocabularies',
					attributes: ['id', 'word', 'meaning', 'example'],
					required: false
				}],
				distinct: true
			});

			const topics = rows.map(topic => ({
				...topic.toJSON(),
				vocabularyCount: topic.vocabularies.length
			}));

			return {
				data: topics,
				pagination: {
					total: count,
					page: parseInt(page),
					limit: parseInt(limit),
					pages: Math.ceil(count / limit)
				}
			};
		} catch (error) {
			throw new Error(`Error fetching topics: ${error.message}`);
		}
	}


	async getTopicsForMe(userId, page = 1, limit = 10) {
		try {
			const user = await User.findByPk(userId);
			if (!user) throw new Error('User not found');

			const offset = (page - 1) * limit;
			const whereClause = {};

			if (user.level) {
				whereClause.level = user.level;
			}

			const { count, rows } = await Topic.findAndCountAll({
				where: whereClause,
				limit: parseInt(limit),
				offset: parseInt(offset),
				order: [['createdAt', 'DESC']],
				attributes: {
					include: [
						[
							Sequelize.literal(`(
								SELECT COUNT(*)
								FROM vocabulary AS v
								WHERE v.topicId = Topic.id
							)`),
							'vocabularyCount'
						]
					]
				}
			});

			const topics = rows.map(topic => ({
				...topic.toJSON()
			}));

			return {
				data: topics,
				pagination: {
					total: count,
					page: parseInt(page),
					limit: parseInt(limit),
					pages: Math.ceil(count / limit)
				}
			};
		} catch (error) {
			throw new Error(`Error fetching topics: ${error.message}`);
		}
	}

	/**
	 * Lấy chi tiết chủ đề
	 */
	async getTopicById(id) {
		try {
			const topic = await Topic.findByPk(id, {
				include: [{
					model: Vocabulary,
					as: 'vocabularies',
					attributes: ['id', 'word', 'meaning', 'example', 'level'],
					required: false
				}]
			});

			if (!topic) {
				throw new Error('Topic not found');
			}

			return topic;
		} catch (error) {
			throw new Error(`Error fetching topic: ${error.message}`);
		}
	}

	/**
 * Liệt kê các chủ đề dưới mức level hiện tại của user
 */
	async getTopicsBelowUserLevel(userId, page = 1, limit = 10) {
		try {
			const user = await User.findByPk(userId);
			if (!user) {
				throw new Error('User not found');
			}
			const offset = (page - 1) * limit;

			// Xác định các level dưới level hiện tại
			const levelsBelow = this.getLevelsBelow(user.level);

			// Lấy tất cả các chủ đề ở các level dưới
			const { count, rows } = await Topic.findAndCountAll({
				where: {
					level: levelsBelow
				},
				limit: parseInt(limit),
				offset: parseInt(offset),
				order: [['level', 'ASC'], ['name', 'ASC']],
				attributes: {
					include: [
						[
							Sequelize.literal(`(
								SELECT COUNT(*)
								FROM vocabulary AS v
								WHERE v.topicId = Topic.id
							)`),
							'vocabularyCount'
						]
					]
				}
			});

			const topics = rows.map(topic => ({
				...topic.toJSON()
			}));

			return {
				data: topics,
				pagination: {
					total: count,
					page: parseInt(page),
					limit: parseInt(limit),
					pages: Math.ceil(count / limit)
				}
			};
		} catch (error) {
			throw new Error(`Error getting topics below user level: ${error.message}`);
		}
	}

	/**
	 * Lấy danh sách các level dưới level hiện tại
	 */
	getLevelsBelow(currentLevel) {
		const levels = ['beginner', 'elementary', 'intermediate', 'advanced', 'expert'];
		const currentIndex = levels.indexOf(currentLevel);
		return currentIndex > 0 ? levels.slice(0, currentIndex) : [];
	}
}

module.exports = new TopicService(); 