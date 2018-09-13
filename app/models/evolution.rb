class Evolution < ApplicationRecord
  include Fae::BaseModelConcern

  #acts_as_list add_new_at: :top
  #default_scope { order(:position) }

  def fae_display_field
    title
  end

  belongs_to :pokemon
  belongs_to :item
  # belongs_to :item
end
