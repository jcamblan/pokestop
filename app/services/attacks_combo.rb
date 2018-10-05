class AttacksCombo

  def get_combos_array(pokemon)
    array = Array.new
    pokemon.fast_attacks.each do |fast_attack|
      pokemon.charge_attacks.each do |charge_attack|
        combo = {
          fast_attack: fast_attack,
          charge_attack: charge_attack,
          att_dps: get_attacking_combo_dps(fast_attack, charge_attack, pokemon),
          def_dps: get_defending_combo_dps(fast_attack, charge_attack, pokemon)
        }
        array << combo
      end
    end
    return array.sort_by { |c| -c[:att_dps] }
  end

  def fill_movesets_table
    Moveset.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('movesets')
    pokemons = Pokemon.all
    pokemons.each do |pokemon|
      pokemon.fast_attacks.each do |fast_attack|
        pokemon.charge_attacks.each do |charge_attack|
            moveset = Moveset.new
            moveset.pokemon_id = pokemon.id
            moveset.fast_attack_id = fast_attack.id
            moveset.charge_attack_id = charge_attack.id
            moveset.raw_attacking_dps = get_attacking_combo_dps(fast_attack,charge_attack,pokemon)
            moveset.raw_defending_dps = get_defending_combo_dps(fast_attack,charge_attack,pokemon)
            moveset.save
        end
      end
    end
  end

  def get_attacking_combo_dps(fast_attack,charge_attack,pokemon)
    fa_damages = get_attack_damages(fast_attack,pokemon)
    ca_damages = get_attack_damages(charge_attack,pokemon)
    ca_energy_cost = get_energy_cost(charge_attack.energy_bars)
    get_dps_if_attacking(fa_damages,fast_attack.cast_time,fast_attack.epu,ca_damages,charge_attack.cast_time,ca_energy_cost,100)
  end

  def get_defending_combo_dps(fast_attack,charge_attack,pokemon)
    fa_damages = get_attack_damages(fast_attack,pokemon)
    ca_damages = get_attack_damages(charge_attack,pokemon)
    ca_energy_cost = get_energy_cost(charge_attack.energy_bars)
    get_dps_if_defending(fa_damages,fast_attack.cast_time,fast_attack.epu,ca_damages,charge_attack.cast_time,ca_energy_cost,100)
  end

  def get_dps_if_attacking(fa_damages,fa_cast_time,fa_epu,ca_damages,ca_cast_time,ca_energy_cost,duration)
    timer = 0
    damage_done = 0
    energy = 0

    while timer < duration do 
      if ca_energy_cost <= energy && (timer + ca_cast_time) < duration
        damage_done += ca_damages
        timer += ca_cast_time
        energy -= ca_energy_cost
        next
      elsif (timer + fa_cast_time) < duration
        damage_done += fa_damages
        if energy + fa_epu <= 100 # En attaque, l'énergie des pokémons est capée à 100
          energy += fa_epu
        else
          energy = 100
        end
        timer += fa_cast_time
        next
      end
      timer += 1
    end

    return (damage_done / timer).round(1)
  end

  def get_dps_if_defending(fa_damages,fa_cast_time,fa_epu,ca_damages,ca_cast_time,ca_energy_cost,duration)
    timer = 0
    damage_done = 0
    energy = 0

    while timer < duration do 
      if timer == 0
        timer += 1
        next
      elsif timer == 1
        damage_done += fa_damages
        energy += fa_epu
        timer += 1
        next
      elsif ca_energy_cost <= energy && (timer + ca_cast_time) < duration
        damage_done += ca_damages
        timer += (ca_cast_time + 2)
        energy -= ca_energy_cost
        next
      elsif (timer + fa_cast_time) < duration
        damage_done += fa_damages
        if energy + fa_epu <= 200 # En défense, l'énergie des pokémons est capée à 200
          energy += fa_epu
        else
          energy = 200
        end
        timer += (fa_cast_time + 2)
        next
      end
      timer += 1
    end

    return (damage_done / timer).round(1)
  end

  def get_attack_damages(attack,pokemon)
    damages = attack.power
    damages *= 1.2 if pokemon.types.include?(attack.type)
    return damages
  end

  def get_energy_cost(energy_bars)
    case energy_bars
    when 1
      cost = 100
    when 2
      cost = 50
    when 3
      cost = 33
    end
    return cost
  end

end