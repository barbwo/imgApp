class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show, :followeds, :followers]
  
  def index
  	@users = User.all
  end
  
  def show
  	@user = User.find(params[:id])
    @pictures = @user.pictures
  end
  
  def followeds
  	@user = User.find(params[:id])
    @users = @user.followeds
  end
  
  def followers
  	@user = User.find(params[:id])
    @users = @user.followers
  end
  
  def newsfeed
    @last_items = current_user.feed.limit(20)
  end

end