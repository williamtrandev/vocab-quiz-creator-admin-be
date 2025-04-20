const express = require('express');
const router = express.Router();
const topicController = require('../controllers/topicController');
const { authenticateToken, isAdmin } = require('../middlewares/authMiddleware');
const { body } = require('express-validator');

// Validation middleware
const validateTopic = [
	body('name').notEmpty().withMessage('Name is required'),
	body('level').isIn(['beginner', 'elementary', 'intermediate', 'advanced', 'expert'])
		.withMessage('Invalid level')
];

// Public routes
router.get('/', topicController.getTopics);
router.get('/me',authenticateToken, topicController.getTopicsForMe);
router.get('/topics-below-level', authenticateToken, topicController.getTopicsBelowLevel);
router.get('/:id', topicController.getTopicById);

// Protected routes (admin only)
router.post('/', authenticateToken, isAdmin, validateTopic, topicController.createTopic);
router.put('/:id', authenticateToken, isAdmin, validateTopic, topicController.updateTopic);
router.delete('/:id', authenticateToken, isAdmin, topicController.deleteTopic);

module.exports = router; 