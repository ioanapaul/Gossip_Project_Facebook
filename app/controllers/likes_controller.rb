class LikesController < ApplicationController
  before_action :authenticate_user
  
  def create
    @gossip = Gossip.find(params[:gossip_id])
    @like = current_user.likes.build(likable: @gossip)
    
    if @like.save
      redirect_back fallback_location: root_path, notice: "Gossip liké!"
    else
      redirect_back fallback_location: root_path, alert: "Vous avez déjà liké ce gossip"
    end
  end
  
  def destroy
    @like = current_user.likes.find(params[:id])
    @like.destroy
    redirect_back fallback_location: root_path, notice: "Like retiré"
  end
  
  private
  
  def authenticate_user
    unless current_user
      flash[:danger] = "Veuillez vous connecter pour effectuer cette action"
      redirect_to login_path
    end
  end
end