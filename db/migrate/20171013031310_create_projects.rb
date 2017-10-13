class CreateProjects < ActiveRecord::Migration[5.1]
    def change
        create_table :projects do |t|
            t.string :title
            t.references :user
            t.string :description
            t.integer :scenario_count, default: 0
            t.timestamps
        end
    end
end
