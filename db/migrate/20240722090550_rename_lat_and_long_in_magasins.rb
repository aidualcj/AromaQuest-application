class RenameLatAndLongInMagasins < ActiveRecord::Migration[7.1]
  def change
    rename_column :magasins, :lat, :latitude
    rename_column :magasins, :long, :longitude
  end
end
