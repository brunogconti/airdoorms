class RoomPolicy < ApplicationPolicy
  class Scope < Scope

      # [...]

  # def create?
  #   return true
  # end

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
end
