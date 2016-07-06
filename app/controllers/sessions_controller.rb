class SessionsController < ApplicationController
  
  def new
  end

  def create 
  	# use is local variable
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  	  log_in user
      #them key cho session hash
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  	  #=redirect_to user_url(user)
  	  redirect_to user 
  	else
	    flash.now[:danger] = 'Invalid email/password combination'  
  	  render 'new'
  	end
  end

  def destroy
    # Log out khi da login, tranh truong hop login tren nhieu tab
    log_out if  logged_in? 
    redirect_to root_url
  end
end
