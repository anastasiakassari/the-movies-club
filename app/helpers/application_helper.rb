module ApplicationHelper
  # Initialize @current_user only if not set
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # Check if there is a logged in user
  def logged_in?
    !!current_user
  end

  def count_likes(ratings)
    ratings.find_all{|r| r.value == 1}.count if ratings != nil
  end
  
  def count_hates(ratings)
    ratings.find_all{|r| r.value == -1}.count if ratings != nil
  end

end
