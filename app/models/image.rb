class Image < ApplicationRecord
  # belongs_to :user
  # belongs_to :product
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>", small: "200x200" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
  belongs_to :entity, polymorphic: true
end
