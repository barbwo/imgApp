class User < ActiveRecord::Base
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable
  
  # Associations
  has_many :active_relationships, class_name:  "Relationship",
            foreign_key: "follower_id", dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
            foreign_key: "followed_id", dependent:   :destroy
  has_many :followeds, through: :active_relationships  # lista obserwowanych przez użytkownika
  has_many :followers, through: :passive_relationships # lista obserwujących  użytkownika

  has_many :pictures, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_pictures, through: :likes, source: :picture
  
  # Validations
  validates :nick, presence: true
  validates_length_of  :nick, in: 2..50 
  validates_length_of :name, maximum: 100

  def follow(other_user) 
    self.active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    self.active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user) 
    self.followeds.include?(other_user) # followeds - obserwowane przez self
  end

  def feed
      following_ids = "SELECT followed_id FROM relationships
                       WHERE  follower_id = :user_id"
      Picture.where("user_id IN (#{following_ids})", user_id: id)
    end

  def admin?
    self.admin == true
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(
                            nick:auth.extra.raw_info.first_name,
                            name:auth.extra.raw_info.name,
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                          )
      end    end
  end
end
