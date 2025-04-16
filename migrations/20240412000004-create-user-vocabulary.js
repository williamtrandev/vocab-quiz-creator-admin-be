'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
	async up(queryInterface, Sequelize) {
		await queryInterface.createTable('user_vocabulary', {
			id: {
				allowNull: false,
				autoIncrement: true,
				primaryKey: true,
				type: Sequelize.INTEGER
			},
			userId: {
				type: Sequelize.INTEGER,
				allowNull: false,
				references: {
					model: 'users',
					key: 'id'
				},
				onDelete: 'CASCADE'
			},
			vocabularyId: {
				type: Sequelize.INTEGER,
				allowNull: false,
				references: {
					model: 'vocabulary',
					key: 'id'
				},
				onDelete: 'CASCADE'
			},
			createdAt: {
				allowNull: false,
				type: Sequelize.DATE,
				defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
			},
			updatedAt: {
				allowNull: false,
				type: Sequelize.DATE,
				defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
			}
		});

		// Thêm unique constraint để tránh trùng lặp
		await queryInterface.addConstraint('user_vocabulary', {
			fields: ['userId', 'vocabularyId'],
			type: 'unique',
			name: 'unique_user_vocabulary'
		});
	},

	async down(queryInterface, Sequelize) {
		await queryInterface.dropTable('user_vocabulary');
	}
}; 