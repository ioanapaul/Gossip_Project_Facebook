class UsersController < ApplicationController
  def new
    @user = User.new
    @cities = City.all
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Compte créé avec succès!"
      redirect_to root_path
    else
      @cities = City.all
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :description, :city_id, :password)
  end
end