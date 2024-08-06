class CreateMagasins < ActiveRecord::Migration[7.1]
  def change
    create_table :magasins do |t|
      t.string :name
      t.string :address
      t.float :lat
      t.float :long
      t.string :photo
      t.string :brand

      t.timestamps
    end
  end
end
