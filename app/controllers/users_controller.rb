class UsersController < ApplicationController

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
      flash[:success] = "Welcome to the Sample App!"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


end
