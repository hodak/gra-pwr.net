module Api
  class ApiController < ApplicationController
    # TODO lol
    def current_user
      User.first
    end
  end
end
