class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show]
  def index
    @communities = policy_scope(Community)
  end

  def show
    authorize @community
  end


  private

  def community_params
    params.require(:community).permit(:name, :description)
  end

  def set_community
    @community = Community.find(params[:id])
  end
end
