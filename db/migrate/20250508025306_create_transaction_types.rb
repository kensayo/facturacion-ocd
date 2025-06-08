class CreateTransactionTypes < ActiveRecord::Migration[8.0]
  def change
    create_table :transaction_types do |t|
      t.string :name
      t.string :description
      t.integer :code

      t.timestamps
    end

    add_index :transaction_types, :name, unique: true
    add_index :transaction_types, :code, unique: true
  end
end
