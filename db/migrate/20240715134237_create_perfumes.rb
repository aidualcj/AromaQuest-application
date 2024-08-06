class CreatePerfumes < ActiveRecord::Migration[7.1]
  def change
    create_table :perfumes do |t|
      t.string :name
      t.text :description
      t.string :brand
      t.decimal :price
      t.string :photo
      t.integer :intensity

      t.timestamps
    end
  end
end
