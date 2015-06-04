class Ability
  include CanCan::Ability

  def initialize(user)
    if user.nil?
      can :index, User
    else
      if user.admin?
        can :manage, :all
      else
        can :manage, User, :id => user.id 
        can :read, User # każdemu zalogowanemu wyświetli profil wybranego użytkownika
        can :followeds, User
        can :followers, User

        can :create, Picture # zdjęcie zawsze jest dodawane dla current_user - nie trzeba sprawdzać
        can :destroy, Picture do |picture|
          picture.try(:user) == User
        end
        
        can :create, Like # dodawanie like zawsze dla current_user
        can :destroy, Like do |like|
          like.try(:user) == user
        end
        
        can :create, Relationship
        can :destroy, Relationship

      end 
    end
  end
end
