class Moveset < ApplicationRecord

  belongs_to :pokemon

  def fast_attack
    Attack.find(fast_attack_id)
  end

  def charge_attack
    Attack.find(charge_attack_id)
  end

  def dps_against(*types)
    fa_dps = self.fast_attack_raw_dps
    ca_dps = self.charge_attack_raw_dps
    if types.count == 1
      type = types.first.first

      if Attack.find(fast_attack_id).type.strengths.include?(type)
        fa_dps *= 2
      elsif Attack.find(fast_attack_id).type.weaknesses.include?(type)
        fa_dps *= 0.5
      elsif Attack.find(fast_attack_id).type.extreme_weaknesses.include?(type)
        fa_dps *= 0
      end
      if Attack.find(charge_attack_id).type.strengths.include?(type)
        ca_dps *= 2
      elsif Attack.find(charge_attack_id).type.weaknesses.include?(type)
        ca_dps *= 0.5
      elsif Attack.find(charge_attack_id).type.extreme_weaknesses.include?(type)
        ca_dps *= 0
      end

      return fa_dps + ca_dps

    else
      type1 = types.first.first
      type2 = types.first.last

      if Attack.find(fast_attack_id).type1.extreme_weaknesses.include?(type) || Attack.find(fast_attack_id).type2.extreme_weaknesses.include?(type)
        fa_dps *= 0
      elsif Attack.find(fast_attack_id).type1.weaknesses.include?(type) && Attack.find(fast_attack_id).type2.weaknesses.include?(type)
        fa_dps *= 0.5 * 0.5
      elsif Attack.find(fast_attack_id).type1.strengths.include?(type) && Attack.find(fast_attack_id).type2.strengths.include?(type)
        fa_dps *= 4
      elsif Attack.find(fast_attack_id).type1.strengths.include?(type) || Attack.find(fast_attack_id).type2.strengths.include?(type)
        fa_dps *= 2
      end
      if Attack.find(charge_attack_id).type1.extreme_weaknesses.include?(type) || Attack.find(charge_attack_id).type2.extreme_weaknesses.include?(type)
        ca_dps *= 0
      elsif Attack.find(charge_attack_id).type1.weaknesses.include?(type) && Attack.find(charge_attack_id).type2.weaknesses.include?(type)
        ca_dps *= 0.5 * 0.5
      elsif Attack.find(charge_attack_id).type1.strengths.include?(type) && Attack.find(charge_attack_id).type2.strengths.include?(type)
        ca_dps *= 4
      elsif Attack.find(charge_attack_id).type1.strengths.include?(type) || Attack.find(charge_attack_id).type2.strengths.include?(type)
        ca_dps *= 2
      end

      return fa_dps + ca_dps

    end
  end

end


