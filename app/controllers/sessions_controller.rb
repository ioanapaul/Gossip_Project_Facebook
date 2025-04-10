class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Connexion réussie"
      redirect_to root_path
    else
      flash.now[:danger] = "Email ou mot de passe incorrect"
      render :new, status: :unprocessable_entity
    end
  end
  
  def destroy
    session.delete(:user_id)
    flash[:success] = "Déconnexion réussie"
    redirect_to root_path
  end
end
