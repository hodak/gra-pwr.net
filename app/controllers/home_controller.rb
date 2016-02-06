class HomeController < ApplicationController
  def index
    if signed_in?
      redirect_to exams_index_url
    end
  end

  def fb_privacy_policy; end
end
