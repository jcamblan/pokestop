class Type < ApplicationRecord

  has_and_belongs_to_many :pokemons
  has_many :attacks

  has_and_belongs_to_many :strengths,
                          :class_name => "Type",
                          :join_table => "strengths_types",
                          :foreign_key => "type_id",
                          :association_foreign_key => "strength_id"
  has_and_belongs_to_many :weaknesses,
                          :class_name => "Type",
                          :join_table => "types_weaknesses",
                          :foreign_key => "type_id",
                          :association_foreign_key => "weakness_id"
  has_and_belongs_to_many :extreme_weaknesses,
                          :class_name => "Type",
                          :join_table => "extreme_weaknesses_types",
                          :foreign_key => "type_id",
                          :association_foreign_key => "extreme_weakness_id"

  def to_param
    "#{self.id}-#{self.name.parameterize}"
  end


  def weak_against
    types = Array.new
    Type.connection.select_all("SELECT type_id FROM strengths_types WHERE strength_id = #{self.id}").each do |t|
      types << Type.find(t['type_id'])
    end
    return types
  end

  def strong_against
    types = Array.new
    Type.connection.select_all("SELECT type_id FROM types_weaknesses WHERE weakness_id = #{self.id}").each do |t|
      types << Type.find(t['type_id'])
    end
    return types
  end

  def very_strong_against
    types = Array.new
    Type.connection.select_all("SELECT type_id FROM extreme_weaknesses_types WHERE extreme_weakness_id = #{self.id}").each do |t|
      types << Type.find(t['type_id'])
    end
    return types
  end

  #------------------------------------------------------------------------
  # pour la gem filterrific
  #------------------------------------------------------------------------

  def self.options_for_select
    order('id').map { |e| [e.name, e.id] }
  end

end
