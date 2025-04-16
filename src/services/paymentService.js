const crypto = require('crypto');
const vnpayConfig = require('../config/vnpay');
const { User } = require('../models');
const querystring = require('qs');
const moment = require('moment');

class PaymentService {
	/**
	 * Tạo URL thanh toán VNPAY
	 */
	async createPaymentUrl(userId, amount, orderInfo) {
		try {
			const user = await User.findByPk(userId);
			if (!user) {
				throw new Error('User not found');
			}

			// Set timezone
			process.env.TZ = 'Asia/Ho_Chi_Minh';

			const date = new Date();
			const createDate = moment(date).format('YYYYMMDDHHmmss');
			const orderId = this.generateOrderId(user.id);

			let vnp_Params = {
				vnp_Version: '2.1.0',
				vnp_Command: 'pay',
				vnp_TmnCode: vnpayConfig.vnp_TmnCode,
				vnp_Locale: 'vn',
				vnp_CurrCode: 'VND',
				vnp_TxnRef: orderId,
				vnp_OrderInfo: 'Thanh toan cho ma GD:' + orderId,
				vnp_OrderType: 'other',
				vnp_Amount: amount * 100,
				vnp_ReturnUrl: vnpayConfig.vnp_ReturnUrl,
				vnp_IpAddr: vnpayConfig.vnp_IpAddr,
				vnp_CreateDate: createDate
			};

			// Sắp xếp các tham số theo thứ tự alphabet
			vnp_Params = this.sortObject(vnp_Params);

			// Tạo chuỗi dữ liệu để mã hóa
			const signData = querystring.stringify(vnp_Params, { encode: false });

			// Tạo chữ ký
			const hmac = crypto.createHmac("sha512", vnpayConfig.vnp_HashSecret);
			const signed = hmac.update(new Buffer(signData, 'utf-8')).digest("hex");

			// Thêm chữ ký vào params
			vnp_Params['vnp_SecureHash'] = signed;

			// Tạo URL thanh toán
			const paymentUrl = vnpayConfig.vnp_Url + '?' + querystring.stringify(vnp_Params, { encode: false });

			return {
				paymentUrl,
				orderId: vnp_Params.vnp_TxnRef
			};
		} catch (error) {
			throw new Error(`Error creating payment URL: ${error.message}`);
		}
	}

	/**
	 * Tạo chuỗi query từ object
	 */
	createQueryString(params) {
		return Object.keys(params)
			.map(key => `${encodeURIComponent(key)}=${encodeURIComponent(params[key])}`)
			.join('&');
	}

	/**
	 * Xác thực kết quả thanh toán
	 */
	validatePaymentResponse(params) {
		try {
			const secureHash = params.vnp_SecureHash;
			delete params.vnp_SecureHash;
			delete params.vnp_SecureHashType;

			const sortedParams = this.sortObject(params);
			const signData = this.createSignData(sortedParams);
			const checkSum = this.createSecureHash(signData);
			return secureHash === checkSum;
		} catch (error) {
			throw new Error(`Error validating payment response: ${error.message}`);
		}
	}

	/**
	 * Tạo mã đơn hàng
	 */
	generateOrderId(userId) {
		const date = new Date();
		const timestamp = date.getTime();
		return `${userId}-${timestamp}`;
	}

	/**
	 * Định dạng ngày tháng theo yêu cầu của VNPAY
	 */
	formatDate(date) {
		const year = date.getFullYear();
		const month = String(date.getMonth() + 1).padStart(2, '0');
		const day = String(date.getDate()).padStart(2, '0');
		const hours = String(date.getHours()).padStart(2, '0');
		const minutes = String(date.getMinutes()).padStart(2, '0');
		const seconds = String(date.getSeconds()).padStart(2, '0');
		return `${year}${month}${day}${hours}${minutes}${seconds}`;
	}

	/**
	 * Sắp xếp object theo key
	 */
	sortObject(obj) {
		let sorted = {};
		let str = [];
		let key;
		for (key in obj) {
			if (obj.hasOwnProperty(key)) {
				str.push(encodeURIComponent(key));
			}
		}
		str.sort();
		for (key = 0; key < str.length; key++) {
			sorted[str[key]] = encodeURIComponent(obj[str[key]]).replace(/%20/g, "+");
		}
		return sorted;
	}

	/**
	 * Tạo chuỗi dữ liệu để mã hóa
	 */
	createSignData(params) {
		return Object.keys(params)
			.filter(key => key !== 'vnp_SecureHash' && key !== 'vnp_SecureHashType')
			.map(key => `${key}=${params[key]}`)
			.join('&');
	}

	/**
	 * Tạo chữ ký
	 */
	createSecureHash(data) {
		return crypto
			.createHmac('sha512', vnpayConfig.vnp_HashSecret)
			.update(data)
			.digest('hex');
	}
}

module.exports = new PaymentService(); 