class Pokemon < ApplicationRecord
  include Fae::BaseModelConcern

  acts_as_list add_new_at: :top
  default_scope { order(:position) }

  def fae_display_field
    name
  end

  belongs_to :generation
end
