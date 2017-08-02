class Post < ActiveRecord::Base
  belongs_to :user
  has_many :likes
  has_many :comments
    has_attached_file :image, styles: { medium: "600x600#", thumb: "190x190#" }, default_url: "/images/:style/missing.png"
   validates_attachment_content_type :image  , content_type: /\Aimage\/.*\z/
   validates_presence_of :image
end
