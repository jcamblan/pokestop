class Attack < ApplicationRecord
  include Fae::BaseModelConcern

  belongs_to :attack_category
  has_and_belongs_to_many :pokemons
  belongs_to :type

  #------------------------------------------------------------------------
  # variable d'affichage pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def fae_display_field
    name
  end

  #------------------------------------------------------------------------
  # filtres pour l'admin FAE CMS
  #------------------------------------------------------------------------

  def self.filter(params)
    # build conditions if specific params are present
    conditions = {}
    conditions[:attack_category_id] = params['attack_category'] if params['attack_category'].present?
  
    # apply conditions and search from above to our scope
    order(:name)
      .includes(:attack_category)
      .where(conditions)
  end

end
