class AlternativeSkin < ApplicationRecord
  include Fae::BaseModelConcern

  acts_as_list add_new_at: :top
  default_scope { order(:position) }

  has_fae_image :illustration

  def fae_display_field
    name
  end

  belongs_to :pokemon
  belongs_to :alternative_skin_category
end
