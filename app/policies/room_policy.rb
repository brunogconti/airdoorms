class RoomPolicy < ApplicationPolicy
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
