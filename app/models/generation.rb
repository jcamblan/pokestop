class Generation < ApplicationRecord
  include Fae::BaseModelConcern

  has_many :pokemons

  def fae_display_field
    name
  end

  def self.options_for_select
    order('id').map { |e| [e.name, e.id] }
  end

end


