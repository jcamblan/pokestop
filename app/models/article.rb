class Article < ApplicationRecord

  has_many_attached :images
  has_and_belongs_to_many :article_categories

end
