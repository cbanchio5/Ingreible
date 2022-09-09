class CommunitiesController < ApplicationController
  before_action :set_community, only: [:show, :update, :edit, :message]

  def message
    @messages = @community.message
  end

  def index
    @communities = policy_scope(Community)
  end

  def show
    authorize @community
  end

  def edit
    authorize @community
  end

  def update
    authorize @community
    @community.update(community_params)
    redirect_to communities_path
  end


  private

  def community_params
    params.require(:community).permit(:name, :description)
  end

  def set_community
    @community = Community.find(params[:id])
  end
end
