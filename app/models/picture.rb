class Picture < ActiveRecord::Base
  # Associations
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :liking_users, through: :likes, source: :user

  #Validations
  validates :user_id, presence: true
  validates :title, length: { maximum: 255 }

  has_attached_file :image, styles: {:original => '500x500#',thumb: ["200x200#", :jpg]},
  path: "/:class/:attachment/:id_partition/:style/:hash.:extension",
  hash_secret: "468a831a37d079bb6ee0b4e31257c14880982d14d505e04486b1b09367ad7d47b6e44936663c14ec09d8efe446fdce0fb3e198c0d9d5c6b74e0264fd68cec322"
  validates_attachment :image, presence: true, size: {in: 0..5.megabytes}
  validates_attachment_content_type :image, content_type: /\Aimage/
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/, /gif\Z/]
  default_scope -> { order(created_at: :desc) }
end
