class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by_email(params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated, true)
      user.update_attribute(:activated_at, Time.zone.now)
      log_in user
      flash[:success] = 'Your account has been activated, enjoy the site'
      redirect_to root_url
    else
      flash[:danger] = "invalid activation link"
    end
  end
end
