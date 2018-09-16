class ArticleCategory < ApplicationRecord
  include Fae::BaseModelConcern

  has_and_belongs_to_many :articles

  def fae_display_field
    name
  end

end
