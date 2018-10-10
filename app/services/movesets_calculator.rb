class MovesetsCalculator

  def fill_movesets_table
    Moveset.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!('movesets')
    pokemons = Pokemon.all
    pokemons.each do |pokemon|
      pokemon.fast_attacks.each do |fast_attack|
        pokemon.charge_attacks.each do |charge_attack|

            attacking_dps_values = get_dps_if_attacking(pokemon,fast_attack,charge_attack)
            defending_dps_values = get_dps_if_defending(pokemon,fast_attack,charge_attack)

            moveset = Moveset.new
            moveset.pokemon_id = pokemon.id
            moveset.fast_attack_id = fast_attack.id
            moveset.fast_attack_raw_dps = attacking_dps_values[:fa_dps]
            moveset.charge_attack_id = charge_attack.id
            moveset.charge_attack_raw_dps = attacking_dps_values[:ca_dps]
            moveset.raw_attacking_dps = attacking_dps_values[:total_dps]
            moveset.raw_defending_dps = defending_dps_values[:total_dps]
            moveset.save
        end
      end
    end
  end

  def get_pokemon_movesets(pokemon)
    movesets = Array.new
    pokemon.fast_attacks.each do |fast_attack|
      pokemon.charge_attacks.each do |charge_attack|
        attacking_dps_values = get_dps_if_attacking(pokemon,fast_attack,charge_attack)
        defending_dps_values = get_dps_if_defending(pokemon,fast_attack,charge_attack)

        moveset = Moveset.new
        moveset.fast_attack_id = fast_attack.id
        moveset.charge_attack_id = charge_attack.id
        moveset.raw_attacking_dps = attacking_dps_values[:total_dps]
        moveset.raw_defending_dps = defending_dps_values[:total_dps]

        movesets << moveset
      end
    end
    return movesets
  end

  def get_dps_if_attacking(pokemon,fast_attack,charge_attack,*target)

    if target.first.nil?
      target = nil
    else
      target = target.first
    end

    ca_energy_cost = get_energy_cost(charge_attack.energy_bars)
    fa_damages = get_damages(pokemon,fast_attack,target)
    ca_damages = get_damages(pokemon,charge_attack,target)

    timer = 0
    damage_done_by_fa = 0
    damage_done_by_ca = 0
    energy = 0
    duration = 100

    while timer < duration do 
      if ca_energy_cost <= energy && (timer + charge_attack.cast_time) < duration
        damage_done_by_ca += ca_damages
        timer += charge_attack.cast_time
        energy -= ca_energy_cost
        next
      elsif (timer + fast_attack.cast_time) < duration
        damage_done_by_fa += fa_damages
        if energy + fast_attack.epu <= 100 # En attaque, l'énergie des pokémons est capée à 100
          energy += fast_attack.epu
        else
          energy = 100
        end
        timer += fast_attack.cast_time
        next
      end
      timer += 1
    end
    damage_done = damage_done_by_fa + damage_done_by_ca
    return {
             fa_dps: (damage_done_by_fa / timer).round(1),
             ca_dps: (damage_done_by_ca / timer).round(1),
             total_dps: (damage_done / timer).round(1)
           }
  end

  def get_dps_if_defending(pokemon,fast_attack,charge_attack,*target)

    if target.first.nil?
      target = nil
    else
      target = target.first
    end

    ca_energy_cost = get_energy_cost(charge_attack.energy_bars)
    fa_damages = get_damages(pokemon,fast_attack,target)
    ca_damages = get_damages(pokemon,charge_attack,target)

    timer = 0
    damage_done_by_fa = 0
    damage_done_by_ca = 0
    energy = 0
    duration = 100

    while timer < duration do 
      if ca_energy_cost <= energy
        damage_done_by_ca += ca_damages
        if timer == 0 || timer == 1
          timer += 1
        else
          timer += 2
        end
        energy -= ca_energy_cost
        next
      else
        damage_done_by_fa += fa_damages
        if energy + fast_attack.epu <= 200 # En défense, l'énergie des pokémons est capée à 200
          energy += fast_attack.epu
        else
          energy = 100
        end
        if timer == 0 || timer == 1
          timer += 1
        else
          timer += 2
        end
        next
      end
      timer += 2
    end
    damage_done = damage_done_by_fa + damage_done_by_ca
    return {
             fa_dps: (damage_done_by_fa / timer).round(1),
             ca_dps: (damage_done_by_ca / timer).round(1),
             total_dps: (damage_done / timer).round(1)
           }
  end

  def get_damages(pokemon,attack,target)
    multipliers = get_multipliers(pokemon,attack,target)
    if target
      return damages = (0.5 * attack.power * (pokemon.atk / target.def) * multipliers).round(0) + 1
    else
      return damages = (attack.power * multipliers).round(0) + 1
    end
  end

  def get_multipliers(pokemon,attack,target)
    multipliers = 1
    multipliers *= 1.2 if pokemon.types.include?(attack.type)

    if target
      multipliers *= 1.4 * 1.4 if target.types_very_strong_against_it && target.types_very_strong_against_it.include?(attack.type)
      multipliers *= 1.4 if target.types_strong_against_it && target.types_strong_against_it.include?(attack.type)
  
      if target.types.count > 1 
        if target.types.first.tough_against.include?(attack.type) && target.types.last.tough_against.include?(attack.type)
          multipliers *= 0.714 * 0.714
        elsif target.types.first.tough_against.include?(attack.type) || target.types.last.tough_against.include?(attack.type)
          multipliers *= 0.714
        end
      else
        if target.types.first.tough_against.include?(attack.type)
          multipliers *= 0.714
        end
      end
  
      if target.types.count > 1 
        if target.types.first.very_tough_against.include?(attack.type) && target.types.last.very_tough_against.include?(attack.type)
          multipliers *= 0.51 * 0.51
        elsif target.types.first.very_tough_against.include?(attack.type) || target.types.last.very_tough_against.include?(attack.type)
          multipliers *= 0.51
        end
      else
        if target.types.first.very_tough_against.include?(attack.type)
          multipliers *= 0.51
        end
      end
    end

    return multipliers
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