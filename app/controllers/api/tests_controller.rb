module Api
  class TestsController < ApiController
    def index
      require'pry';binding.pry
      render json: Test.all
    end
  end
end
