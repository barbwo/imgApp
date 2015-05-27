class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]
  
  has_many :active_relationships, class_name:  "Relationship",
            foreign_key: "follower_id", dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
            foreign_key: "followed_id", dependent:   :destroy
  						
  has_many :followeds, through: :active_relationships # lista obserw. przez użytk.
  has_many :followers, through: :passive_relationships #lista obserw.  użytk.

  validates :nick, presence: true, uniqueness: true
  validates_length_of  :nick, in: 2..50 
  validates_length_of :name, maximum: 100

def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name   # assuming the user model has a name
    user.image = auth.info.image # assuming the user model has an image
  end
end
def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def follow(other_user) 
    self.active_relationships.create(followed_id: other_user.id)
  end

  def unfollow(other_user)
    self.active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user) 
    self.followeds.include?(other_user) # followeds - obserwowane przez self
  end

end
