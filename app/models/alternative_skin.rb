class AlternativeSkin < ApplicationRecord

  validates :name, presence: true
  validates :name_en, presence: true
  validates :nametag, presence: true

  belongs_to :pokemon, touch: true

  def shiny?
    return self.shiny
  end

end
