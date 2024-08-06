class AddBudgetToResults < ActiveRecord::Migration[7.1]
  def change
    add_column :results, :budget_min, :integer
    add_column :results, :budget_max, :integer
  end
end
