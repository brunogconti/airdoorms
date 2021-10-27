class RoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    create?
  end

  def create?
    is_owner?
  end

  private

  def is_owner?
    record.user == user
  end
end
