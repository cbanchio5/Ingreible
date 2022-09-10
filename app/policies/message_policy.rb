class MessagePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
    def resolve
      if user.communities.include?(scope.all.first.community)
       scope.all
      else
        raise Pundit::NotAuthorizedError, 'Not allowed to view this action'
      end
    end
  end

  def show?
    user.communities.include?(scope.all.first.community)
  end

  def new?
    user.communities.include?(scope.all.first.community)
  end

  def create?
    user.communities.include?(scope.all.first.community)
  end

  def destroy?
    user.admin
  end
end
