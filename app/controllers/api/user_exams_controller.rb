module Api
  class UserExamsController < ApiController
    def index
      render json: UserExam.all
    end
  end
end
