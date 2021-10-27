class RoomPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def new?
    create?
  end

  private

  def is_owner?
    record.user == user
  end
end
