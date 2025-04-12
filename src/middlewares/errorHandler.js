/**
 * Error Handler Middleware
 */
const errorHandler = (err, req, res, next) => {
	console.error(err.stack);

	// Kiểm tra loại lỗi để định hình response phù hợp
	if (err.name === 'SequelizeValidationError' || err.name === 'SequelizeUniqueConstraintError') {
		return res.status(400).json({
			success: false,
			message: 'Validation error',
			errors: err.errors.map(e => e.message)
		});
	}

	if (err.name === 'SequelizeDatabaseError') {
		return res.status(500).json({
			success: false,
			message: 'Database error',
			error: process.env.NODE_ENV === 'development' ? err.message : 'Something went wrong with the database'
		});
	}

	// Lỗi mặc định
	const statusCode = err.statusCode || 500;
	res.status(statusCode).json({
		success: false,
		message: err.message || 'Internal Server Error',
		stack: process.env.NODE_ENV === 'development' ? err.stack : null
	});
};

module.exports = errorHandler;