class MatchPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    owner? 
    true
  end

  def create?
    true
  end

  def destroy?
    owner?
  end

  private

  def owner?
    record.user == user
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
