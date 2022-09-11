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
    user.communities.include?(record.community)
  end

  def new?

  end

  def create?
    user.communities.include?(record.community)
  end

  def destroy?
    user.admin || record.user == user
  end
end
