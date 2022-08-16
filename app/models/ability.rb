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

    can :crud, NewsArticle do |news_article|
      user == news_article.user
    end

    can :like, Review do |review|
      user.persisted? && review.user != user
    end

    can :destroy, Like do |like|
      user == like.user 
    end
  end
end
