class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :index]
  before_action :correct_user, only: [:edit, :update]

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

  def edit
    @user = User.find(params[:id])
  end

  def index

    # Bad idea to retrieve all users at once
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # Success update
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end

    # Define filters

    # Dam bao logged-in user 
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirm the correct user
    def correct_user
      @user = User.find(params[:id])
      # current user co y sua thong tin cua other user thi chuyen ve root
      redirect_to(root_url) unless current_user?(@user)
    end

end
