class Moveset < ApplicationRecord

  belongs_to :pokemon

  def fast_attack
    Attack.find(fast_attack_id)
  end

  def charge_attack
    Attack.find(charge_attack_id)
  end

end


