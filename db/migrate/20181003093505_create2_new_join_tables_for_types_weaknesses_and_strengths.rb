class Create2NewJoinTablesForTypesWeaknessesAndStrengths < ActiveRecord::Migration[5.2]
  def change
    create_table "types_weaknesses", id: false, force: :cascade do |t|
      t.integer "type_id"
      t.integer "weakness_id"
    end
    create_table "strengths_types", id: false, force: :cascade do |t|
      t.integer "type_id"
      t.integer "strength_id"
    end
  end
end
