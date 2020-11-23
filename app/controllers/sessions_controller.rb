class SessionsController < ApplicationController

  # gets go here
  def new
    # debugger

  end
  # posts go here
  def create

    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      reset_session
      log_in user
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end

  end

  def destroy

  end

  private

end
