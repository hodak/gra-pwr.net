module Api
  class ApiController < ApplicationController
    before_action :authenticate_user!

    def authenticate_user!
      head 401 unless signed_in?
    end
  end
end
