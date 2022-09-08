class CommunityPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def resolve
    scope.all
  end

  def index?
    true
  end

  def show?
    true
  end
end
