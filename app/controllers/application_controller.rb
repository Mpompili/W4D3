class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  def login!(user)
    session[:session_token] = user.session_token
    flash[:success] = "Successfully logged in!"
    redirect_to user_url(user)
  end

  def login?
    !!current_user
  end

  def log_out!
    current_user.reset_session_token!
    session[:session_token] = nil
    flash[:success] = "Successfully logged out"
    redirect_to new_session_url
  end

  def current_user
    return nil unless session[:session_token].present?
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
end
