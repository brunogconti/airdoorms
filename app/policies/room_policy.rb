class RoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    true
  end

  def new?
    create?
  end

  def destroy?
    owner?
  end

  private

  def owner?
    record.user == user
  end
end
