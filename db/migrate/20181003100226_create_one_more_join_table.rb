class CreateOneMoreJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table "extreme_weaknesses_types", id: false, force: :cascade do |t|
      t.integer "type_id"
      t.integer "extreme_weakness_id"
    end
  end
end
