module Api
  class ExamsController < ApiController
    def show
      render json: { exam: ExamRepresenter.new(Exam.find(params[:id])).to_h }
    rescue ActiveRecord::RecordNotFound
      render json: { error: ['Exam not found'] }, status: 404
    rescue PG::InvalidTextRepresentation
      render json: { error: ['Is not valid UUID'] }, status: 422
    end

    def update
      form = ExamForm.new(exam_params)

      if form.valid?
        exam = Exam.find_or_initialize_by({ id: form.id })
        exam.update!(form.to_h)
        conditionally_create_user_exam(exam)

        render json: { exam: ExamRepresenter.new(exam).to_h }
      else
        render json: { error: form.errors }, status: 422
      end
    end

    private
      def exam_params
        params.require(:exam).permit(:name).merge({ id: params[:id] })
      end

      def conditionally_create_user_exam(exam)
        return if current_user.exams.exists?(id: exam.id)
        current_user.user_exams.create! exam: exam
      end
  end
end
