module SessionsHelper
  
  # Logs in the  given user
  def log_in(user)
  	session[:user_id] = user.id #method session cua Rails, khac voi Session
  end

  # Returns true if the given user is the current usser
  def current_user?(user)
    user == current_user
  end

  # Returns the current logged -in (if any)
  def current_user
  	@current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise
  def logged_in?
  	!current_user.nil?
  end

  # Redirects to stored location ( or to the default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Store the URL tring to be accessed.
  def store_location
    # Get requested url
    # chi GET method moi save, prevent post, patch, delete
    session[:forwarding_url] = request.original_url if request.get?
  end

  #Logs out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
