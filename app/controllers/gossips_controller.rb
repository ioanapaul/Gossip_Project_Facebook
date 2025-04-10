# app/controllers/gossips_controller.rb
class GossipsController < ApplicationController
  before_action :authenticate_user, except: [:index]
  before_action :set_gossip, only: [:show, :edit, :update, :destroy]
  before_action :check_gossip_owner, only: [:edit, :update, :destroy]
  
  def index
    @gossips = Gossip.all.order(created_at: :desc)
  end
  
  def show
    @comment = Comment.new
    @comments = @gossip.comments.order(created_at: :desc)
  end
  
  def new
    @gossip = Gossip.new
  end
  
  def create
    @gossip = current_user.gossips.build(gossip_params)
    
    if @gossip.save
      flash[:success] = "Potin créé avec succès!"
      redirect_to gossips_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @gossip.update(gossip_params)
      flash[:success] = "Potin mis à jour avec succès!"
      redirect_to @gossip
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @gossip.destroy
    flash[:success] = "Potin supprimé avec succès!"
    redirect_to gossips_path
  end
  
  private
  
  def set_gossip
    @gossip = Gossip.find(params[:id])
  end
  
  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end
  
  def check_gossip_owner
    unless @gossip.user == current_user
      flash[:danger] = "Vous n'êtes pas autorisé à modifier ce potin"
      redirect_to gossips_path
    end
  end
end
