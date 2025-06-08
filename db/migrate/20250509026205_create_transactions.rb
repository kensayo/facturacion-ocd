class CreateTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :transactions do |t|
      t.float :amount
      t.date :date
      t.string :description
      t.text :details
      t.float :exchange_rate
      t.string :invoice_number
      t.boolean :is_income, default: true

      t.references :account, foreign_key: true
      t.references :user, foreign_key: true
      t.references :transaction_type, foreign_key: true
      t.timestamps
    end
  end
end
