# app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user
  
  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      flash[:success] = "Commentaire ajouté avec succès!"
    else
      flash[:danger] = "Erreur lors de l'ajout du commentaire"
    end
    redirect_to gossip_path(@gossip)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content)
  end
end