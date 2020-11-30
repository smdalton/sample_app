class UsersController < ApplicationController
  before_action :logged_in_user,  only: [ :edit, :update, :index, :destroy]
  before_action :correct_user,    only: [ :edit, :update]
  before_action :admin_user,      only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    # debugger
  end

  def new
    # debugger
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    # when the post goes out to this route, we access the values for the new user
    # object by accessing the instance variable returned as params[:user] which
    # came from the new method above
    # Rails takes the input from the form with name=user[email] and stores the email input into
    # the hash called user which is made available via params above after receiving the post
    if @user.save
      reset_session
      log_in @user
      flash[:success] = 'Welcome to the Sample App!'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      #success
      flash[:success] = 'Profile Updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User Deleted'
    redirect_to users_url
  end
  private

  def user_params
    params.require( :user ).permit(:name, :email, :password, :password_confirmation)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

end
