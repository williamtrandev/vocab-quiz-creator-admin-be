const { sequelize } = require('../config/database');
const { DataTypes } = require('sequelize');

// Định nghĩa model Vocabulary
const Vocabulary = sequelize.define('Vocabulary', {
	id: {
		type: DataTypes.INTEGER,
		primaryKey: true,
		autoIncrement: true
	},
	word: {
		type: DataTypes.STRING(255),
		allowNull: false
	},
	meaning: {
		type: DataTypes.TEXT,
		allowNull: false
	},
	example: {
		type: DataTypes.TEXT,
		allowNull: true
	},
	level: {
		type: DataTypes.ENUM('beginner', 'elementary', 'intermediate', 'advanced', 'expert'),
		allowNull: false
	},
	topicId: {
		type: DataTypes.INTEGER,
		allowNull: true,
		references: {
			model: 'Topics',
			key: 'id'
		}
	},
	createdAt: {
		type: DataTypes.DATE,
		allowNull: false,
		defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
	},
	updatedAt: {
		type: DataTypes.DATE,
		allowNull: false,
		defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
	}
}, {
	tableName: 'vocabulary',
	timestamps: true,
	underscored: false,
	timezone: '+07:00',
	toJSON: {
		transform: (doc, ret) => {
			ret.createdAt = ret.createdAt;
			ret.updatedAt = ret.updatedAt;
			return ret;
		}
	}
});

// Định nghĩa model QuestionSet
const QuestionSet = sequelize.define('QuestionSet', {
	id: {
		type: DataTypes.INTEGER,
		primaryKey: true,
		autoIncrement: true
	},
	name: {
		type: DataTypes.STRING(255),
		allowNull: false
	},
	description: {
		type: DataTypes.TEXT,
		allowNull: true
	},
	level: {
		type: DataTypes.ENUM('beginner', 'elementary', 'intermediate', 'advanced', 'expert'),
		allowNull: false
	},
	totalQuestions: {
		type: DataTypes.INTEGER,
		allowNull: false,
		defaultValue: 0
	},
	createdAt: {
		type: DataTypes.DATE,
		allowNull: false,
		defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
	},
	updatedAt: {
		type: DataTypes.DATE,
		allowNull: false,
		defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
	}
}, {
	tableName: 'question_sets',
	timestamps: true,
	underscored: false,
	timezone: '+07:00',
	toJSON: {
		transform: (doc, ret) => {
			ret.createdAt = ret.createdAt;
			ret.updatedAt = ret.updatedAt;
			return ret;
		}
	}
});

// Định nghĩa model Question
const Question = sequelize.define('Question', {
	id: {
		type: DataTypes.INTEGER,
		primaryKey: true,
		autoIncrement: true
	},
	questionSetId: {
		type: DataTypes.INTEGER,
		allowNull: false,
		references: {
			model: 'question_sets',
			key: 'id'
		}
	},
	vocabularyId: {
		type: DataTypes.INTEGER,
		allowNull: false,
		references: {
			model: 'vocabulary',
			key: 'id'
		}
	},
	correctAnswer: {
		type: DataTypes.STRING(255),
		allowNull: false
	},
	wrongAnswer1: {
		type: DataTypes.STRING(255),
		allowNull: false
	},
	wrongAnswer2: {
		type: DataTypes.STRING(255),
		allowNull: false
	},
	wrongAnswer3: {
		type: DataTypes.STRING(255),
		allowNull: false
	},
	createdAt: {
		type: DataTypes.DATE,
		allowNull: false,
		defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
	},
	updatedAt: {
		type: DataTypes.DATE,
		allowNull: false,
		defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
	}
}, {
	tableName: 'questions',
	timestamps: true,
	underscored: false,
	timezone: '+07:00',
	toJSON: {
		transform: (doc, ret) => {
			ret.createdAt = ret.createdAt;
			ret.updatedAt = ret.updatedAt;
			return ret;
		}
	}
});

// Định nghĩa model User
const User = sequelize.define('User', {
	id: {
		type: DataTypes.INTEGER,
		primaryKey: true,
		autoIncrement: true
	},
	name: {
		type: DataTypes.STRING,
		allowNull: false
	},
	username: {
		type: DataTypes.STRING,
		allowNull: false
	},
	password: {
		type: DataTypes.STRING,
		allowNull: false
	},
	role: {
		type: DataTypes.ENUM('admin', 'learner'),
		allowNull: false,
		defaultValue: 'learner'
	},
	level: {
		type: DataTypes.ENUM('beginner', 'elementary', 'intermediate', 'advanced', 'expert'),
		allowNull: true
	}
}, {
	tableName: 'users',
	timestamps: true,
	indexes: [
		{
			unique: true,
			fields: ['username']
		}
	]
});

// Định nghĩa model UserVocabulary
const UserVocabulary = sequelize.define('UserVocabulary', {
	id: {
		type: DataTypes.INTEGER,
		primaryKey: true,
		autoIncrement: true
	},
	userId: {
		type: DataTypes.INTEGER,
		allowNull: false,
		references: {
			model: 'users',
			key: 'id'
		}
	},
	vocabularyId: {
		type: DataTypes.INTEGER,
		allowNull: false,
		references: {
			model: 'vocabulary',
			key: 'id'
		}
	},
	createdAt: {
		type: DataTypes.DATE,
		allowNull: false,
		defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
	},
	updatedAt: {
		type: DataTypes.DATE,
		allowNull: false,
		defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
	}
}, {
	tableName: 'user_vocabulary',
	timestamps: true,
	underscored: false,
	timezone: '+07:00'
});

// Thiết lập quan hệ giữa các model
QuestionSet.hasMany(Question, {
	foreignKey: 'questionSetId',
	as: 'questions'
});
Question.belongsTo(QuestionSet, {
	foreignKey: 'questionSetId',
	as: 'questionSet'
});

Question.belongsTo(Vocabulary, {
	foreignKey: 'vocabularyId',
	as: 'vocabulary'
});
Vocabulary.hasMany(Question, {
	foreignKey: 'vocabularyId',
	as: 'questions'
});

// Thiết lập quan hệ giữa User và Vocabulary thông qua UserVocabulary
User.belongsToMany(Vocabulary, {
	through: UserVocabulary,
	foreignKey: 'userId',
	otherKey: 'vocabularyId'
});

Vocabulary.belongsToMany(User, {
	through: UserVocabulary,
	foreignKey: 'vocabularyId',
	otherKey: 'userId'
});

// Topic model
const Topic = sequelize.define('Topic', {
	id: {
		type: DataTypes.INTEGER,
		primaryKey: true,
		autoIncrement: true
	},
	name: {
		type: DataTypes.STRING,
		allowNull: false
	},
	description: {
		type: DataTypes.TEXT,
		allowNull: true
	},
	level: {
		type: DataTypes.ENUM('beginner', 'elementary', 'intermediate', 'advanced', 'expert'),
		allowNull: false
	},
	createdAt: {
		type: DataTypes.DATE,
		allowNull: false,
		defaultValue: sequelize.literal('CURRENT_TIMESTAMP'),
	},
	updatedAt: {
		type: DataTypes.DATE,
		allowNull: false,
		defaultValue: sequelize.literal('CURRENT_TIMESTAMP'),
	}
}, {
	timestamps: true,
	timezone: '+07:00',
	toJSON: {
		transform: (doc, ret) => {
			ret.createdAt = ret.createdAt;
			ret.updatedAt = ret.updatedAt;
			return ret;
		}
	}
});

// Add associations
Topic.hasMany(Vocabulary, { 
	foreignKey: 'topicId',
	as: 'vocabularies'
});
Vocabulary.belongsTo(Topic, { 
	foreignKey: 'topicId',
	as: 'topic' 
});

// Hàm kiểm tra kết nối database
async function testConnection() {
	try {
		await sequelize.authenticate();
		console.log('Database connection has been established successfully.');
	} catch (error) {
		console.error('Unable to connect to the database:', error);
		throw error;
	}
}

// Hàm đồng bộ hóa database
async function syncDatabase() {
	try {
		// Đồng bộ hóa theo thứ tự để tránh lỗi khóa ngoại
		await Vocabulary.sync({ alter: true });
		await QuestionSet.sync({ alter: true });
		await Question.sync({ alter: true });
		await User.sync({ alter: true });
		await UserVocabulary.sync({ alter: true });
		console.log('Database synchronized successfully.');
	} catch (error) {
		console.error('Error synchronizing database:', error);
		throw error;
	}
}

module.exports = {
	sequelize,
	Vocabulary,
	Question,
	QuestionSet,
	User,
	UserVocabulary,
	testConnection,
	syncDatabase,
	Topic
};