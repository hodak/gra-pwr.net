module Api
  class UserExamsController < ApiController
    def index
      render json: user_exams
    end

    # TODO: this method is untested :O
    def show
      user_exam = current_user.user_exams.find_or_initialize_by(exam_id: params[:exam_id])
      render json: UserExamRepresenter.new(user_exam).to_h
    end

    # TODO global api handling of 404 active record not found
    # TODO this method is untested :O
    def sync_user_answers
      user_exam = current_user.user_exams.find(params[:id])
      user_exam.user_answers.create! user_answers_params

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
  end
end
