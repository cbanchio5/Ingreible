class MembershipsController < ApplicationController
  def index
    @memberships = policy_scope(Membership).where(user_id: current_user)
  end

  def show
    @membership = Membership.find(params[:id])
    authorize @membership
  end

  def new
    @membership =  Membership.new
    authorize @membership
    @community = Community.find(params[:communitiy_id])
    authorize @community
  end

  def create
    @membership = Membership.new(params[:id])
    authorize @membership
    @community = Community.find(params[:community_id])
    @membership.community_id = @community.id
    @membership.user_id = current_user.id
    #relationship does not exist
   if  @membership.save
    redirect_to community_messages_path(@community)
   else
    flash[:notice] = "Error"
   end

  end

  def destroy
    @membership = Membership.find(params[:id])
    authorize @membership
    #raise
    @membership.destroy
    redirect_to user_memberships_path(current_user.id)
  end
end
