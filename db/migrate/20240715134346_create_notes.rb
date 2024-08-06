class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :notes do |t|
      t.references :perfume, null: false, foreign_key: true
      t.string :tete
      t.string :coeur
      t.string :fond

      t.timestamps
    end
  end
end
