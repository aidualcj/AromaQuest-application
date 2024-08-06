class CreatePerfumesResults < ActiveRecord::Migration[7.1]
  def change
    create_table :perfumes_results do |t|
      t.string :perfume_ids
      t.integer :result_id

      t.timestamps
    end
  end
end
