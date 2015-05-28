class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :picture
  validates :user_id, presence: true
  validates :picture_id, presence: true
end
