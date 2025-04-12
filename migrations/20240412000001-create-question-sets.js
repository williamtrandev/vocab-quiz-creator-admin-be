'use strict';

/** @type {import('sequelize-cli').Migration} */
module.exports = {
	async up(queryInterface, Sequelize) {
		await queryInterface.createTable('question_sets', {
			id: {
				allowNull: false,
				autoIncrement: true,
				primaryKey: true,
				type: Sequelize.INTEGER
			},
			name: {
				type: Sequelize.STRING(255),
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
			totalQuestions: {
				type: Sequelize.INTEGER,
				allowNull: false,
				defaultValue: 0
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
		await queryInterface.dropTable('question_sets');
	}
}; 