class AddSmellToPerfumes < ActiveRecord::Migration[7.1]
  def change
    add_column :perfumes, :smell, :string
  end
end
