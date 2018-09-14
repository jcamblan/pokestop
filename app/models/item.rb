class Item < ApplicationRecord
  include Fae::BaseModelConcern

  #acts_as_list add_new_at: :top
  #default_scope { order(:position) }

  has_fae_image :illustration

  def fae_display_field
    name
  end

  belongs_to :item_category
end
