class Candy < ApplicationRecord
  include Fae::BaseModelConcern
  def fae_display_field
    name
  end

  def image_path

  	return "candy/#{id}.png"

  end

end
