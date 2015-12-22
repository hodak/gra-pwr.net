class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.omniauth(env['omniauth.auth'])
    session[:user_id] = user.id

    redirect_to exams_index_url
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_url
  end

  def failure
    redirect_to login_error_url
  end
end
