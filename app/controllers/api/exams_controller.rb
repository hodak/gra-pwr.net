module Api
  class ExamsController < ApiController
    def update
      form = ExamForm.new(exam_params)

      if form.valid?
        exam = Exam.find_or_initialize_by({ id: form.id })
        exam.update!(form.to_h)

        render json: { exam: ExamRepresenter.new(exam).to_h }
      else
        render json: { error: form.errors }, status: 422
      end
    end

    private
      def exam_params
        params.require(:exam).permit(:name).merge({ id: params[:id] })
      end
  end
end
