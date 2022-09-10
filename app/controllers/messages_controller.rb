class MessagesController < ApplicationController

  before_action :set_community, only: [:new, :create]

  def show
    @message = Message.find(params[:id])
    authorize @message
  end

  def new
    # we need @restaurant in our `simple_form_for`

    @message = Message.new
    authorize @message
    authorize @community
  end

  def create
    @message = Message.new(message_params)
    # we need `recipe_id` to associate review with corresponding recipe
    authorize @message
    authorize @community
    @message.user_id = current_user.id
    @message.community_id = @community.id
    redirect_to community_messages_path(@community)

  end


  private

  def set_community
    @community = Community.find(params[:community_id])
  end

  def message_params
    params.require(:message).permit(:message)
  end
end
