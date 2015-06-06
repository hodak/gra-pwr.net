module Api
  class UserExamsController < ApiController
    def index
      render json: user_exams
    end

    # TODO: this method is untested :O
    def show
      Exam.find(params[:exam_id])

      user_exam = current_user.user_exams.find_or_initialize_by(exam_id: params[:exam_id])
      user_exam.save! unless user_exam.persisted?
      render json: UserExamRepresenter.new(user_exam).to_h
    end

    def update
      ue = UserExam.find(params[:id])
      ue.update! user_exam_params

      head 200
    end

    # TODO global api handling of 404 active record not found
    # TODO this method is untested :O
    # TODO don't raise error if you try to add one uid twice, just ignore it
    def sync_user_answers
      return head :ok if params[:user_answers].blank?

      user_exam = current_user.user_exams.find(params[:id])
      user_exam.user_answers.create! user_answers_params

      head :ok
    end

    def destroy
      UserExam.find(params[:id]).destroy

      head :ok
    end

    private
      def user_exams
        UserExam.for_user(current_user).map do |user_exam|
          UserExamRepresenter.new(user_exam).simple
        end
      end

      def user_answers_params
        params.permit(user_answers: [:id, :question_id, answers: []])[:user_answers]
      end

      def user_exam_params
        params.require(:user_exam).permit(:repeat, :repeat_wrong)
      end
  end
end
