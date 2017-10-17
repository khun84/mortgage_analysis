class ChangeDepositToInteger < ActiveRecord::Migration[5.1]
  def up
      change_column :scenarios, :deposit, :integer
  end

    def down
        change_column :scenarios, :deposit, :decimal
    end
end
