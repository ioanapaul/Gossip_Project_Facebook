class GossipController < ApplicationController
def show
  @gossip = Gossip.find(params[:id])
end

def create_comment
  @gossip = Gossip.find(params[:id])
  @comment = @gossip.comments.new(comment_params)
  @comment.user = current_user
  if @comment.save
    redirect_to gossip_path(@gossip), notice: "Commentaire ajouté."
  else
    render :show
  end
end
