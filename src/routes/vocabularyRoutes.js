const express = require('express');
const VocabularyController = require('../controllers/vocabularyController');
const router = express.Router();

/**
 * @route   GET /api/vocabulary
 * @desc    Lấy tất cả từ vựng với phân trang
 * @access  Public
 */
router.get('/', VocabularyController.getAllVocabularies);

/**
 * @route   GET /api/vocabulary/search
 * @desc    Tìm kiếm từ vựng
 * @access  Public
 */
router.get('/search', VocabularyController.searchVocabulary);

/**
 * @route   GET /api/vocabulary/:id
 * @desc    Lấy từ vựng theo ID
 * @access  Public
 */
router.get('/:id', VocabularyController.getVocabularyById);

/**
 * @route   POST /api/vocabulary
 * @desc    Tạo từ vựng mới
 * @access  Private
 */
router.post('/', VocabularyController.createVocabulary);

/**
 * @route   PUT /api/vocabulary/:id
 * @desc    Cập nhật từ vựng
 * @access  Private
 */
router.put('/:id', VocabularyController.updateVocabulary);

/**
 * @route   DELETE /api/vocabulary/:id
 * @desc    Xóa từ vựng
 * @access  Private
 */
router.delete('/:id', VocabularyController.deleteVocabulary);

module.exports = router;