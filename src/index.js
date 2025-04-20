const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
require('dotenv').config();

// Import database configuration
const { testConnection, syncDatabase } = require('./models');

// Import middlewares
const errorHandler = require('./middlewares/errorHandler');
const notFoundHandler = require('./middlewares/notFoundHandler');
const requestLogger = require('./middlewares/requestLogger');

// Import routes
const vocabularyRoutes = require('./routes/vocabularyRoutes');
const questionSetRoutes = require('./routes/questionSetRoutes');
const questionRoutes = require('./routes/questionRoutes');
const userRoutes = require('./routes/userRoutes');
const topicRoutes = require('./routes/topicRoutes');
const paymentRoutes = require('./routes/paymentRoutes');

// Khởi tạo Express app
const app = express();
app.set('trust proxy', true);

// Middleware
app.use(helmet()); // Bảo mật HTTP headers
app.use(cors()); // Cho phép CORS
app.use(express.json()); // Parse JSON requests
app.use(express.urlencoded({ extended: true }));
app.use(requestLogger); // Log requests

// Health check route
app.get('/api/health', (req, res) => {
	res.status(200).json({
		status: 'ok',
		timestamp: new Date().toISOString()
	});
});

// API routes
app.use('/api/vocabulary', vocabularyRoutes);
app.use('/api/question-sets', questionSetRoutes);
app.use('/api/questions', questionRoutes);
app.use('/api/users', userRoutes);
app.use('/api/topics', topicRoutes);
app.use('/api/payment', paymentRoutes); 

// 404 handler
app.use(notFoundHandler);

// Error handling middleware
app.use(errorHandler);

// Khởi động server
const PORT = process.env.PORT || 3000;

async function startServer() {
	try {
		// Test database connection
		await testConnection();

		// Sync database models
		if (process.env.NODE_ENV !== 'production') {
			await syncDatabase();
		}

		// Start server
		app.listen(PORT, () => {
			console.log(`Server is running on port ${PORT}`);
		});
	} catch (error) {
		console.error('Failed to start server:', error);
		process.exit(1);
	}
}

startServer();

module.exports = app;