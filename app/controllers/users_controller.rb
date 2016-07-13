class UsersController < ApplicationController

  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy


  def new #GET method
    @user = User.new
  end

  def show #GET method
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    # redirect_to root_url and return unless FILL_IN
    # redirect_to root_url and return unless true
  	# debugger -> for debugging directly
  end

  def create #POST method
  	@user = User.new(user_params) #ko du params -> thieu + gay ra loi
  	if @user.save
      # log_in @user
      # flash[:success] = "Welcome to the Sample App!"
      # redirect_to @user
      # UserMailer.account_activation(@user).deliver_now
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url

  	else
  		render 'new'
  	end
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    # @users = User.where(activated: FILL_IN).paginate(page: params[:page])
    @users = User.where(activated: true).paginate(page: params[:page])
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

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
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
  #end
end
