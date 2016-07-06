module SessionsHelper
  
  # Logs in the  given user
  def log_in(user)
  	session[:user_id] = user.id #method session cua Rails, khac voi Session
  end

  # Returns the current logged -in (if any)
  def current_user
  	if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user_id
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise
  def logged_in?
  	!current_user.nil?
  end

  # Remembers a user in a perisent session
  def remember(user)
    #ham nay dinh nghia trong model
    user.remember
    #ham cua Rails, sau khi remember -> tao cookies
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent.signed[:remember_token] = user.remember_token
  end

  # Forgets a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #Logs out the current user
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
