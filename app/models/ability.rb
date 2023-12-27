# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    case user&.role&.title
    when 'admin'
      can :manage, :all
    when 'user'
      can :read, :all
      can :manage, User
    else
      can :read, Category
    end
  end
end
