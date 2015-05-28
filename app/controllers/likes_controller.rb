class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
  	picture = Picture.find(params[:picture_id])
    Like.create(picture: picture, user: current_user)
    redirect_to newsfeed_user_path current_user
  end
  def destroy 
  	Like.find(params[:id]).destroy
    redirect_to newsfeed_user_path current_user
  end

end
