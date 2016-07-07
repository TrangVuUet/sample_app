class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

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

    @users = User.paginate(page: params[:page])
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
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

    # Only admin can delete the user
    # Tranh case delete bang dong lenh
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end
