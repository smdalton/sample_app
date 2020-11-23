module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    # current user equals itself if not nil, else hit the DB and get the session info
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end

