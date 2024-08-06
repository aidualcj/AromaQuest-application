class AddAnswersToResults < ActiveRecord::Migration[7.1]
  def change
    add_column :results, :answer_5, :string
    add_column :results, :answer_6, :string
    add_column :results, :answer_7, :string
    add_column :results, :answer_8, :string
    add_column :results, :answer_9, :string
    add_column :results, :answer_10, :string
  end
end
