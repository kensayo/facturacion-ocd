class CreateHouses < ActiveRecord::Migration[8.0]
  def change
    create_table :houses do |t|
      t.string :state
      t.string :name
      t.string :shortname
      t.string :address
      t.string :city
      t.string :country
      t.string :email
      t.integer :code

      t.timestamps
    end
    
    add_index :houses, :code, unique: true
  end
end
