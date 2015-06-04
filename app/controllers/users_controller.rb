class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :followeds, :followers, :newsfeed, :liked_pictures]
  load_and_authorize_resource
  
  def index
  	@users = User.order(:nick).paginate(page: params[:page], per_page: 10)
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
    @last_items = current_user.feed
  end

  def liked_pictures
    @user = User.find(params[:id])
    @pictures = current_user.liked_pictures
  end
end