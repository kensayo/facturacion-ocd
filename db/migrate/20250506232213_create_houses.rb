class CreateHouses < ActiveRecord::Migration[8.0]
  def change
    create_table :houses do |t|
      t.string :state
      t.string :name
      t.string :shortname
      t.timestamps
    end
  end
end
