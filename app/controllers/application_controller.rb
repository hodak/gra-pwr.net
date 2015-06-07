class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  include JsEnv
  include AngularExamsHelper

  helper_method :signed_in?, :current_user

  def signed_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end
end
