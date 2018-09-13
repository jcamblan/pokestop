class Evolution < ApplicationRecord
  include Fae::BaseModelConcern

  #acts_as_list add_new_at: :top
  #default_scope { order(:position) }

  def fae_display_field
    title
  end

  def item
    return Item.find(item_id)
  end

  belongs_to :pokemon
end
