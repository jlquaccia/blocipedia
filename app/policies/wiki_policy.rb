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
      wikis = []
      if user
        if user.role == 'admin'
          wikis = scope.all # if the user is an admin, show them all the wikis
        elsif user.role == 'premium'
          all_wikis = scope.all
          all_wikis.each do |wiki|
            if wiki.private == false || wiki.user == user || wiki.collaborators.pluck(:user_id).include?(user.id)
              wikis << wiki # if the user is premium, only show them public wikis, or private wikis they created, or private wikis they are a collaborator on
            end
          end
        else
          all_wikis = scope.all
          all_wikis.each do |wiki|
            if wiki.private == false || wiki.collaborators.pluck(:user_id).include?(user.id)
              wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
            end
          end
        end
      else
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private == false
            wikis << wiki # if no logged in only show public wikis
          end
        end
      end
      wikis # return the wikis array we've built up
    end
  end
end