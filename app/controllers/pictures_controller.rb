class PicturesController < ApplicationController
 before_action :authenticate_user!
 load_and_authorize_resource
 
 def create 
 	@picture = current_user.pictures.build(picture_params)
    if @picture.save
      flash[:notice] = "Zdjęcie dodane!"
      redirect_to root_url
    else
      render 'application/index', alert: "Zdjęcie nie zostało dodane."
    end
 end

 def destroy 
   @picture = Picture.find(params[:id])
   @picture.destroy
   flash[:notice] = "Zdjęcie zostało usunięte."
   redirect_to :back
 end

private
  def picture_params
    params.require(:picture).permit(:image, :title)
  end

end
