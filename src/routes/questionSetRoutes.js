const express = require('express');
const { authenticateToken, isAdmin } = require('../middlewares/authMiddleware');
const QuestionSetController = require('../controllers/questionSetController');
const router = express.Router();

/**
 * @route   GET /api/question-sets
 * @desc    Lấy tất cả Question Sets với phân trang
 * @access  Public
 */
router.get('/', authenticateToken, QuestionSetController.getAllQuestionSets);

/**
 * @route   GET /api/question-sets/:id
 * @desc    Lấy Question Set theo ID
 * @access  Public
 */
router.get('/:id', authenticateToken, QuestionSetController.getQuestionSetById);

/**
 * @route   POST /api/question-sets
 * @desc    Tạo Question Set mới
 * @access  Private
 */
router.post('/', authenticateToken, isAdmin, QuestionSetController.createQuestionSet);

/**
 * @route   PUT /api/question-sets/:id
 * @desc    Cập nhật Question Set
 * @access  Private
 */
router.put('/:id', authenticateToken, isAdmin, QuestionSetController.updateQuestionSet);

/**
 * @route   DELETE /api/question-sets/:id
 * @desc    Xóa Question Set
 * @access  Private
 */
router.delete('/:id', authenticateToken, isAdmin, QuestionSetController.deleteQuestionSet);

/**
 * @route   GET /api/question-sets/:id/vocabularies
 * @desc    Lấy danh sách từ vựng trong một Question Set
 * @access  Public
 */
router.get('/:id/vocabularies', authenticateToken, QuestionSetController.getVocabulariesInQuestionSet);

/**
 * @route   POST /api/question-sets/:id/vocabularies
 * @desc    Thêm từ vựng vào Question Set
 * @access  Private
 */
router.post('/:id/vocabularies', authenticateToken, isAdmin, QuestionSetController.addVocabularyToQuestionSet);

/**
 * @route   DELETE /api/question-sets/:id/vocabularies/:vocabularyId
 * @desc    Xóa từ vựng khỏi Question Set
 * @access  Private
 */
router.delete('/:id/vocabularies/:vocabularyId', authenticateToken, isAdmin, QuestionSetController.removeVocabularyFromQuestionSet);

module.exports = router;