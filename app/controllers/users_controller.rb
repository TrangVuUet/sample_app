class UsersController < ApplicationController

  def new #GET method
  	@user = User.new
  end

  def show #GET method
  	@user = User.find(params[:id])
  	#debugger -> for debugging directly
  end

  def create #POST method
  	@user = User.new(user_params) #ko du params -> thieu + gay ra loi
  	if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
  	else
  		render 'new'
  	end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
