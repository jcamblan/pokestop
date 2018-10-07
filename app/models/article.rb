class Article < ApplicationRecord

  has_many_attached :images
  has_and_belongs_to_many :tags
  belongs_to :image

end
