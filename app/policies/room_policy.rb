class RoomPolicy < ApplicationPolicy
  class Scope < Scope

      # [...]

  # def create?
  #   return true
  # end

    def resolve
      scope.all
    end
  end
end
