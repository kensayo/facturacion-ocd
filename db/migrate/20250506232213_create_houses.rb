class CreateHouses < ActiveRecord::Migration[8.0]
  def change
    create_table :houses do |t|
      t.string :state     # Define una columna 'title' de tipo string
      t.string :name       # Define una columna 'body' de tipo text
      t.timestamps       # Crea automáticamente dos columnas: created_at y updated_at (tipo datetime)
    end
  end
end
