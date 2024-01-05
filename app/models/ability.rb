# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    case user&.role&.title
    when 'owner'
      can :manage, :all
      can :manage, ActiveAdmin::Page, name: 'Dashboard', namespace_name: 'admin'
    when 'admin'
      can :manage, :all
      can :read, :all
      cannot :manage, ActiveAdmin::Page
    when 'user'
      can :read, :all
      can :manage, User
      cannot :manage, ActiveAdmin::Page
    else
      can :read, Category
      cannot :manage, ActiveAdmin::Page
    end
  end
end
