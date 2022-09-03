class FavouritesController < ApplicationController
def index
  @favourites = policy_scope(Favourite)
end
def new
  @favourite =  Favourite.new
end
def create
  @favourite = Favourite.new(favourite_params)

end

private

# def favourite_params
#   params.require(:recipe).permit(:address, :description, photos: [])
# end
end
