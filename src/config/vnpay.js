module.exports = {
	vnp_TmnCode: process.env.VNPAY_TMN_CODE, // Mã website của merchant trên hệ thống của VNPAY
	vnp_HashSecret: process.env.VNPAY_HASH_SECRET, // Chuỗi bí mật
	vnp_Url: process.env.VNPAY_URL || 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html', // URL thanh toán
	vnp_ReturnUrl: process.env.VNPAY_RETURN_URL || 'http://localhost:3000/api/payment/vnpay-return', // URL trả về sau khi thanh toán
	vnp_ApiUrl: process.env.VNPAY_API_URL || 'https://sandbox.vnpayment.vn/merchant_webapi/api/transaction', // URL API
	vnp_Version: '2.1.0', // Phiên bản API
	vnp_Command: 'pay', // Lệnh thanh toán
	vnp_CurrCode: 'VND', // Đơn vị tiền tệ
	vnp_Locale: 'vn', // Ngôn ngữ giao diện
	vnp_IpAddr: '127.0.0.1' // IP của khách hàng
}; 