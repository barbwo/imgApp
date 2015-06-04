class Like < ActiveRecord::Base
  #Associations
  belongs_to :user
  belongs_to :picture

  # Validations
  validates :user_id, presence: true
  validates :picture_id, presence: true
end
