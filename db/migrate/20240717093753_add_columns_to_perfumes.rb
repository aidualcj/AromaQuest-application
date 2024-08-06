class AddColumnsToPerfumes < ActiveRecord::Migration[7.1]
  def change
    add_column :perfumes, :genre, :string
    add_column :perfumes, :period, :string
    add_column :perfumes, :season, :string
    add_column :perfumes, :situations, :string
  end
end
