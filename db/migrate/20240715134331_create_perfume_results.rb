class CreatePerfumeResults < ActiveRecord::Migration[7.1]
  def change
    create_table :perfume_results do |t|
      t.references :perfume, null: false, foreign_key: true
      t.references :result, null: false, foreign_key: true

      t.timestamps
    end
  end
end
