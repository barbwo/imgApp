class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show, :followeds, :followers]
  
  def index
  	@users = User.all
  end
  
  def show
  	@user = User.find(params[:id])
  end
  
  def followeds
  	@user = User.find(params[:id])
    @title = "Obserwowani  przez " + @user.nick
    @users = @user.followeds
  end
  
  def followers
  	@user = User.find(params[:id])
    @title = "Obserwatorzy " + @user.nick
    @users = @user.followers
  end

end