class Attack < ApplicationRecord
  include Fae::BaseModelConcern

  belongs_to :attack_category

  def fae_display_field
    name
  end

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
