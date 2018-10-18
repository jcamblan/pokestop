class Article < ApplicationRecord

  has_many_attached :images
  has_and_belongs_to_many :tags

  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]


  def should_generate_new_friendly_id?
    title_changed?
  end

end