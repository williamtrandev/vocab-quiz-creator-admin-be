'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
	async up(queryInterface, Sequelize) {
		await queryInterface.createTable('questions', {
			id: {
				allowNull: false,
				autoIncrement: true,
				primaryKey: true,
				type: Sequelize.INTEGER
			},
			questionSetId: {
				type: Sequelize.INTEGER,
				allowNull: false,
				references: {
					model: 'question_sets',
					key: 'id'
				},
				onUpdate: 'CASCADE',
				onDelete: 'CASCADE'
			},
			vocabularyId: {
				type: Sequelize.INTEGER,
				allowNull: false,
				references: {
					model: 'vocabulary',
					key: 'id'
				},
				onUpdate: 'CASCADE',
				onDelete: 'CASCADE'
			},
			correctAnswer: {
				type: Sequelize.STRING(255),
				allowNull: false
			},
			wrongAnswer1: {
				type: Sequelize.STRING(255),
				allowNull: false
			},
			wrongAnswer2: {
				type: Sequelize.STRING(255),
				allowNull: false
			},
			wrongAnswer3: {
				type: Sequelize.STRING(255),
				allowNull: false
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
	},

	async down(queryInterface, Sequelize) {
		await queryInterface.dropTable('questions');
	}
}; 