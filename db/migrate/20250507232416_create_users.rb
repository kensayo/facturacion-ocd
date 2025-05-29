class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.text :username
      t.text :name
      t.text :lastname
      t.date :birthdate
      t.string :user_role
      t.string :remember_digest
      t.string :password_digest

      t.timestamps

      t.references :house, foreign_key: true
    end

    add_index :users, :username, unique: true
  end
end
