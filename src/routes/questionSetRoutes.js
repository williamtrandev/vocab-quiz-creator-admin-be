const express = require('express');
const QuestionSetController = require('../controllers/questionSetController');
const router = express.Router();

/**
 * @route   GET /api/question-sets
 * @desc    Lấy tất cả Question Sets với phân trang
 * @access  Public
 */
router.get('/', QuestionSetController.getAllQuestionSets);

/**
 * @route   GET /api/question-sets/:id
 * @desc    Lấy Question Set theo ID
 * @access  Public
 */
router.get('/:id', QuestionSetController.getQuestionSetById);

/**
 * @route   POST /api/question-sets
 * @desc    Tạo Question Set mới
 * @access  Private
 */
router.post('/', QuestionSetController.createQuestionSet);

/**
 * @route   PUT /api/question-sets/:id
 * @desc    Cập nhật Question Set
 * @access  Private
 */
router.put('/:id', QuestionSetController.updateQuestionSet);

/**
 * @route   DELETE /api/question-sets/:id
 * @desc    Xóa Question Set
 * @access  Private
 */
router.delete('/:id', QuestionSetController.deleteQuestionSet);

/**
 * @route   GET /api/question-sets/:id/vocabularies
 * @desc    Lấy danh sách từ vựng trong một Question Set
 * @access  Public
 */
router.get('/:id/vocabularies', QuestionSetController.getVocabulariesInQuestionSet);

/**
 * @route   POST /api/question-sets/:id/vocabularies
 * @desc    Thêm từ vựng vào Question Set
 * @access  Private
 */
router.post('/:id/vocabularies', QuestionSetController.addVocabularyToQuestionSet);

/**
 * @route   DELETE /api/question-sets/:id/vocabularies/:vocabularyId
 * @desc    Xóa từ vựng khỏi Question Set
 * @access  Private
 */
router.delete('/:id/vocabularies/:vocabularyId', QuestionSetController.removeVocabularyFromQuestionSet);

module.exports = router;