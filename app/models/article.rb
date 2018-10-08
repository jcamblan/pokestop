class Article < ApplicationRecord

  has_many_attached :images
  has_and_belongs_to_many :tags

  def to_param
    "#{self.id}-#{self.title.parameterize}"
  end

end
