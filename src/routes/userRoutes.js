const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const { authenticateToken, isAdmin } = require('../middlewares/authMiddleware');
const { body } = require('express-validator');

// Validation middleware
const validateRegister = [
	body('name').notEmpty().withMessage('Name is required'),
	body('age').isInt({ min: 1 }).withMessage('Age must be a positive number'),
	body('username').notEmpty().withMessage('Username is required'),
	body('password').isLength({ min: 6 }).withMessage('Password must be at least 6 characters'),
	body('role').optional().isIn(['admin', 'learner']).withMessage('Invalid role'),
	body('level').optional().isIn(['beginner', 'elementary', 'intermediate', 'advanced', 'expert'])
		.withMessage('Invalid level')
];

const validateLogin = [
	body('username').notEmpty().withMessage('Username is required'),
	body('password').notEmpty().withMessage('Password is required')
];

// Public routes
router.post('/register', validateRegister, userController.register);
router.post('/login', validateLogin, userController.login);

// Protected routes
router.get('/learners', authenticateToken, isAdmin, userController.getLearners);
router.put('/:id', authenticateToken, userController.updateUser);

// Lấy danh sách từ vựng của người dùng
router.get('/vocabularies', authenticateToken, userController.getUserVocabularies);

// Đánh dấu từ vựng đã học
router.post('/vocabularies/:vocabularyId/learned', authenticateToken, userController.markVocabularyAsLearned);

// Đánh dấu từ vựng chưa học
router.post('/vocabularies/:vocabularyId/unlearned', authenticateToken, userController.markVocabularyAsUnlearned);

module.exports = router; 