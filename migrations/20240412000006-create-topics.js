'use strict';

module.exports = {
	up: async (queryInterface, Sequelize) => {
		// Tạo bảng topics
		await queryInterface.createTable('topics', {
			id: {
				type: Sequelize.INTEGER,
				primaryKey: true,
				autoIncrement: true
			},
			name: {
				type: Sequelize.STRING,
				allowNull: false
			},
			description: {
				type: Sequelize.TEXT,
				allowNull: true
			},
			level: {
				type: Sequelize.ENUM('beginner', 'elementary', 'intermediate', 'advanced', 'expert'),
				allowNull: false
			},
			createdAt: {
				type: Sequelize.DATE,
				allowNull: false,
				defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
			},
			updatedAt: {
				type: Sequelize.DATE,
				allowNull: false,
				defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
			}
		});

		// Thêm cột topicId vào bảng vocabularies
		await queryInterface.addColumn('vocabulary', 'topicId', {
			type: Sequelize.INTEGER,
			allowNull: true,
			references: {
				model: 'topics',
				key: 'id'
			},
			onUpdate: 'CASCADE',
			onDelete: 'SET NULL'
		});
	},

	down: async (queryInterface, Sequelize) => {
		// Xóa cột topicId khỏi bảng vocabularies
		await queryInterface.removeColumn('vocabulary', 'topicId');

		// Xóa bảng topics
		await queryInterface.dropTable('topics');
	}
}; 