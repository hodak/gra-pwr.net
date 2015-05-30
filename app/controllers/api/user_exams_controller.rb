module Api
  class UserExamsController < ApiController
    def index
      render json: user_exams
    end

    private
      def user_exams
        UserExam.for_user(current_user).map do |user_exam|
          UserExamRepresenter.new(user_exam).to_h
        end
      end
  end
end
