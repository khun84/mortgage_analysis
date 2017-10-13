class CreateScenarios < ActiveRecord::Migration[5.1]
    def change
        create_table :scenarios do |t|
            t.string :name
            t.decimal :deposit
            t.decimal :interest
            t.integer :tenure
            t.integer :buying_price
            t.integer :selling_price
            t.integer :rental
            t.integer :rental_increment
            t.integer :rental_start
            t.integer :rental_end
            t.integer :purchase_transaction_cost
            t.integer :sell_transaction_cost
            t.integer :holding_period
            t.references :project
            t.timestamps
        end
    end
end
