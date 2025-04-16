const paymentService = require('../services/paymentService');
const { validationResult } = require('express-validator');
const { User } = require('../models');

class PaymentController {
	/**
	 * Tạo URL thanh toán
	 */
	async createPaymentUrl(req, res) {
		try {
			const errors = validationResult(req);
			if (!errors.isEmpty()) {
				return res.status(400).json({ errors: errors.array() });
			}

			const { amount, orderInfo } = req.body;
			const userId = req.user.id; // Lấy từ token

			const result = await paymentService.createPaymentUrl(userId, amount, orderInfo);

			res.json({
				success: true,
				data: result
			});
		} catch (error) {
			res.status(500).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Xử lý kết quả thanh toán
	 */
	async handlePaymentReturn(req, res) {
		try {
			const params = req.query;

			// Kiểm tra tính hợp lệ của kết quả thanh toán
			const isValid = paymentService.validatePaymentResponse(params);

			if (!isValid) {
				return res.status(400).json({
					success: false,
					message: 'Invalid payment response'
				});
			}

			// Kiểm tra kết quả thanh toán
			if (params.vnp_ResponseCode === '00') {
				// Thanh toán thành công
				// Lấy userId từ orderId (format: userId-timestamp)
				const orderId = params.vnp_TxnRef;
				const userId = orderId.split('-')[0];

				// Cập nhật level của user
				const user = await User.findByPk(userId);
				if (user) {
					// Xác định level mới dựa trên level hiện tại
					const currentLevel = user.level;
					let newLevel;

					switch (currentLevel) {
						case 'beginner':
							newLevel = 'elementary';
							break;
						case 'elementary':
							newLevel = 'intermediate';
							break;
						case 'intermediate':
							newLevel = 'advanced';
							break;
						case 'advanced':
							newLevel = 'expert';
							break;
						case 'expert':
							newLevel = 'expert'; // Giữ nguyên nếu đã là expert
							break;
						default:
							newLevel = 'beginner'; // Mặc định là beginner nếu không có level
					}

					await user.update({ level: newLevel });
				}

				res.json({
					success: true,
					message: 'Payment successful',
					data: {
						orderId: params.vnp_TxnRef,
						amount: params.vnp_Amount / 100, // Chia 100 vì VNPAY trả về số tiền đã nhân 100
						bankCode: params.vnp_BankCode,
						transactionNo: params.vnp_TransactionNo,
						payDate: params.vnp_PayDate,
						newLevel: user ? user.level : null
					}
				});
			} else {
				// Thanh toán thất bại
				res.json({
					success: false,
					message: 'Payment failed',
					data: {
						orderId: params.vnp_TxnRef,
						responseCode: params.vnp_ResponseCode,
						message: params.vnp_Message
					}
				});
			}
		} catch (error) {
			res.status(500).json({
				success: false,
				message: error.message
			});
		}
	}
}

module.exports = new PaymentController(); 