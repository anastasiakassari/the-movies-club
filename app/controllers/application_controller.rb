class ApplicationController < ActionController::Base
  # Initialize @current_user only if not set
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Check if there is a logged in user
  def logged_in?
    !!current_user
  end

  # User should be logged in
  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end
  
  # User should be admin
  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "Only admins can perform this action"
      redirect_back fallback_location: root_path 
    end
  end

end
