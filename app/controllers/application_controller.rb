class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  include JsEnv
  include AngularExamsHelper

  force_ssl if: :force_ssl?
  helper_method :signed_in?, :current_user

  def signed_in?
    !!current_user
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  private
  def force_ssl?
    ENVied.FORCE_SSL || false
  end
end
