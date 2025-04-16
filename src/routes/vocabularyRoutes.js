const express = require('express');
const VocabularyController = require('../controllers/vocabularyController');
const router = express.Router();
const { authenticateToken, isAdmin } = require('../middlewares/authMiddleware');

/**
 * @route   GET /api/vocabulary
 * @desc    Lấy tất cả từ vựng với phân trang
 * @access  Public
 */
router.get('/', authenticateToken, VocabularyController.getAllVocabularies);

/**
 * @route   GET /api/vocabulary/search
 * @desc    Tìm kiếm từ vựng
 * @access  Public
 */
router.get('/search', authenticateToken, VocabularyController.searchVocabulary);

/**
 * @route   GET /api/vocabulary/:id
 * @desc    Lấy từ vựng theo ID
 * @access  Public
 */
router.get('/:id', authenticateToken, VocabularyController.getVocabularyById);

/**
 * @route   POST /api/vocabulary
 * @desc    Tạo từ vựng mới
 * @access  Private
 */
router.post('/', authenticateToken, isAdmin, VocabularyController.createVocabulary);

/**
 * @route   PUT /api/vocabulary/:id
 * @desc    Cập nhật từ vựng
 * @access  Private
 */
router.put('/:id', authenticateToken, isAdmin, VocabularyController.updateVocabulary);

/**
 * @route   DELETE /api/vocabulary/:id
 * @desc    Xóa từ vựng
 * @access  Private
 */
router.delete('/:id', authenticateToken, isAdmin, VocabularyController.deleteVocabulary);

module.exports = router;