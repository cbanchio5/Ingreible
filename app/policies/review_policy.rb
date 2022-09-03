class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
     def resolve
       scope.all
     end
  end

  def show?
    true
  end
  def new?
    current.user?
  end
  def create?
    current.user?
  end
  def destroy?
    user.admin
  end
end
