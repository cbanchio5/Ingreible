class ReviewsController < ApplicationController
  def new
    # we need @restaurant in our `simple_form_for`
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new
  end
  def create
    @review = Review.new(review_params)
    # we need `recipe_id` to associate review with corresponding recipe
    @recipe = Recipe.find(params[:recipe_id])
    @review.recipe = @recipe
    @review.save
    redirect_to recipe_path(@recipe)
  end

  private

  def review_params
    params.require(:review).permit(:content)
  end
end
