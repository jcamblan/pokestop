class Generation < ApplicationRecord
  include Fae::BaseModelConcern

  has_many :pokemons

  #acts_as_list add_new_at: :top
  #default_scope { order(:position) }

  def fae_display_field
    name
  end

end
