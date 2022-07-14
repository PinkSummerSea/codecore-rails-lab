# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.is_admin?
      can :manage, :all
    end

    alias_action :create, :read, :update, :delete, to: :crud

    can :crud, Product do |product|
      user == product.user
    end

    can :crud, Review do |review|
      user == review.user
    end
  end
end
