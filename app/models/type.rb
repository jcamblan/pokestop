class Type < ApplicationRecord
  include Fae::BaseModelConcern

  acts_as_list add_new_at: :top
  default_scope { order(:position) }

  has_fae_image :logo

  def fae_display_field
    name
  end

  has_and_belongs_to_many :pokemons

end
