require('dotenv').config();
const { Sequelize } = require('sequelize');

const sequelize = new Sequelize(
	process.env.DB_NAME,
	process.env.DB_USER,
	process.env.DB_PASSWORD,
	{
		host: process.env.DB_HOST,
		dialect: 'mysql',
		logging: process.env.NODE_ENV === 'development' ? console.log : false,
		timezone: '+07:00',
		dialectOptions: {
			dateStrings: true,
			typeCast: true,
			timezone: '+07:00'
		},
		define: {
			timestamps: true,
			underscored: false
		},
		pool: {
			max: 10,
			min: 0,
			acquire: 30000,
			idle: 10000
		}
	}
);

module.exports = {
	sequelize
};