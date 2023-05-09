class ApplicationController < ActionController::Base
  # Whatever we add to application controller will be available to all other Controlers
  helper_method :current_user, :logged_in?
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # The !! turns the following variable into a boolean
    !!current_user
  end

  def require_user
    return if logged_in?

    flash[:alert] = 'You must be logged in'
    redirect_to login_path
  end
end
