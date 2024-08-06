class CreateResults < ActiveRecord::Migration[7.1]
  def change
    create_table :results do |t|
      t.integer :questionnaire_id
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.string :answer_1
      t.string :answer_2
      t.string :answer_3
      t.string :answer_4

      t.timestamps
    end
  end
end
