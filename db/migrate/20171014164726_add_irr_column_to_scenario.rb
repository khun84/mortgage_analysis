class AddIrrColumnToScenario < ActiveRecord::Migration[5.1]
  def change
      add_column :scenarios, :irr, :decimal
  end
end
