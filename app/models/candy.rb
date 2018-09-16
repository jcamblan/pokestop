class Candy < ApplicationRecord
  include Fae::BaseModelConcern
  def fae_display_field
    name
  end

  def image_path
  	return "candy/#{self.image_name}.png"
  end

  def image_name
    return name_en.parameterize
  end

end
