const express = require('express');
const router = express.Router();
const paymentController = require('../controllers/paymentController');
const { authenticateToken } = require('../middlewares/authMiddleware');
const { body } = require('express-validator');

// Validation middleware
const validatePayment = [
	body('amount').isNumeric().withMessage('Amount must be a number'),
	body('orderInfo').notEmpty().withMessage('Order info is required')
];

// Protected routes
router.post('/create-payment-url', authenticateToken, validatePayment, paymentController.createPaymentUrl);

// Public routes
router.get('/vnpay-return', paymentController.handlePaymentReturn);

module.exports = router; 