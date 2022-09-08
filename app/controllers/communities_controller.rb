class CommunitiesController < ApplicationController

  def index
    @communitites = Community.all
  end
end
