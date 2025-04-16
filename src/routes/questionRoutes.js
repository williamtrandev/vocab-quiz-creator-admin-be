const express = require('express');
const router = express.Router();
const QuestionController = require('../controllers/questionController');
const { authenticateToken, isAdmin } = require('../middlewares/authMiddleware');

// Tạo câu hỏi mới
router.post('/', authenticateToken, isAdmin, QuestionController.createQuestion);

// Lấy tất cả câu hỏi của một question set
router.get('/question-set/:questionSetId', authenticateToken, QuestionController.getQuestionsByQuestionSetId);

// Xóa câu hỏi
router.delete('/:id', authenticateToken, isAdmin, QuestionController.deleteQuestion);

module.exports = router; 