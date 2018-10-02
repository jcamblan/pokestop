class Article < ApplicationRecord

  has_many_attached :images
  has_and_belongs_to_many :tags

end
