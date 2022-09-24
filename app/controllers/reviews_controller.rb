class ReviewsController < ApplicationController

  def show
    @review = Review.find(params[:id])
    authorize @review
  end

  def new
    # we need @restaurant in our `simple_form_for`
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.new
    authorize @review
    authorize @recipe
  end

  def create
    @review = Review.new(review_params)
    # we need `recipe_id` to associate review with corresponding recipe
    authorize @review
    @recipe = Recipe.find(params[:recipe_id])
    authorize @recipe
    @review.user_id = current_user.id
    @review.recipe_id = @recipe.id
    @review.recipe = @recipe
    if @review.save
      redirect_to recipe_path(@recipe)
    else
      render :new
    end

  end

  def index
    @reviews = policy_scope(Review)
    @reviews = Review.where(recipe_id: params[:recipe_id] )
    @review = Review.new
    authorize @review

  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
