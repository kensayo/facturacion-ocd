class CreateAccounts < ActiveRecord::Migration[8.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.float :balance
      t.integer :code
      t.timestamps
      
      t.references :currency, foreign_key: true
      t.references :house, foreign_key: true
    end
    
    add_index :accounts, [:code, :house_id], unique: true
  end
end
