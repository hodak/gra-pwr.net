module Api
  class ExamsController < ApiController
    def index
      require'pry';binding.pry
      render json: Exam.all
    end
  end
end
