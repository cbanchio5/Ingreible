class FavouritesController < ApplicationController

def index

  @favourites = policy_scope(Favourite).where(user_id: current_user).includes(:recipe)
  @recipes = policy_scope(Recipe).sample(6)
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
    redirect_to recipes_path
    #redirect_to user_favourites_path(current_user.id)
  else
    flash[:notice] = "Error"
  end

end

def destroy
  puts "ESTE ES LA REQUEST #{request.headers["referer"]}"
  @favourite = Favourite.find(params[:id])
  authorize @favourite
  #raise
  @favourite.destroy
  if request.headers["referer"].include?("recipes")
    redirect_to recipes_path
  else
    redirect_to user_favourites_path(current_user)
  end
end

end
