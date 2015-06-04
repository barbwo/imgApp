class LikesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  
  respond_to :html, :js
  
  def create
  	@pic = Picture.find(params[:picture_id])
    Like.create(picture: @pic, user: current_user)
  end
  
  def destroy 
    @pic = Picture.find(Like.find(params[:id]).picture_id)
  	Like.find(params[:id]).destroy
  end

end
