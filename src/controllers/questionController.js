const QuestionService = require('../services/questionService');

class QuestionController {
	/**
	 * Tạo câu hỏi mới
	 */
	async createQuestion(req, res) {
		try {
			const question = await QuestionService.createQuestion(req.body);

			res.status(201).json({
				success: true,
				data: question
			});
		} catch (error) {
			res.status(400).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Lấy tất cả câu hỏi của một question set
	 */
	async getQuestionsByQuestionSetId(req, res) {
		try {
			const { questionSetId } = req.params;
			const questions = await QuestionService.getQuestionsByQuestionSetId(questionSetId);

			res.status(200).json({
				success: true,
				data: questions
			});
		} catch (error) {
			res.status(400).json({
				success: false,
				message: error.message
			});
		}
	}

	/**
	 * Xóa câu hỏi
	 */
	async deleteQuestion(req, res) {
		try {
			const { id } = req.params;
			await QuestionService.deleteQuestion(id);

			res.status(200).json({
				success: true,
				message: 'Question deleted successfully'
			});
		} catch (error) {
			res.status(400).json({
				success: false,
				message: error.message
			});
		}
	}
}

module.exports = new QuestionController(); 