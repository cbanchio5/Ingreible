class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    authorize @user
    if current_user.id == @user.id
      authorize @user
    else
      redirect_to recipes_path
    end
  end
end
