const express = require('express');
const router = express.Router();
const QuestionController = require('../controllers/questionController');

// Tạo câu hỏi mới
router.post('/', QuestionController.createQuestion);

// Lấy tất cả câu hỏi của một question set
router.get('/question-set/:questionSetId', QuestionController.getQuestionsByQuestionSetId);

// Xóa câu hỏi
router.delete('/:id', QuestionController.deleteQuestion);

module.exports = router; 