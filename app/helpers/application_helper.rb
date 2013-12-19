module ApplicationHelper
  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def login!
    session[:session_token] = @user.session_token
  end

  def logout!
    current_user.reset_session_token!
    session[:session_token] = nil
  end

  def require_login
    unless logged_in?
      flash[:errors] = ["You must be logged in"]
      redirect_to new_session_url
    end
  end
end
