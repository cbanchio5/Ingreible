class FavouritesController < ApplicationController

def index

  @favourites = policy_scope(Favourite).where(user_id: current_user).includes(:recipe)
  # if @favourites.user_id == current_user.id
  #   @favourites = policy_scope(Favourite)
  # end
end

def show
  @favourite = Favourite.find(params[:id])
  authorize @favourite
end

def new
  @favourite =  Favourite.new
  authorize @favourite
  @recipe = Recipe.find(params[:recipe_id])
  authorize @recipe
end

def create
  @favourite = Favourite.new(params[:id])
  authorize @favourite
  @recipe = Recipe.find(params[:recipe_id])
  @favourite.recipe_id = @recipe.id
  @favourite.user_id = current_user.id
  #relationship does not exist
 if  @favourite.save
  flash[:notice] = "Saved succesfully"
  #redirect_to user_favourites_path(current_user.id)
 else
  flash[:notice] = "Error"
 end

end

def destroy
  @favourite = Favourite.find(params[:id])
  authorize @favourite
  #raise
  @favourite.destroy
  redirect_to user_favourites_path(current_user.id)
end

end
