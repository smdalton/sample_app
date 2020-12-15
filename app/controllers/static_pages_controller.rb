class StaticPagesController < ApplicationController

  def home
    # create a blank micrpost forum for easy posting if logged in
    @micropost = current_user.microposts.build if logged_in?
    # load a recent selection of microposts from the current user
    @feed_items = current_user.feed.paginate(page: params[:page]) if logged_in?


  end

  def help
  end

  def about
  end

  def contact
  end
end
