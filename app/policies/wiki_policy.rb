class WikiPolicy < ApplicationPolicy
  def index?
    user.present?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user
        if user.admin? || user.premium?
          scope.all
        else
          scope.where(:private => false)
        end
      else
        scope.where(:private => false)
      end
    end
  end
end