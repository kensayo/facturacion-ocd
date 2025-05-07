class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.text :coin_type
      t.float :amount
      t.date :date
      t.string :description
      t.text :details
      t.text :type
      t.float :exchange_rate

      t.references :house, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
