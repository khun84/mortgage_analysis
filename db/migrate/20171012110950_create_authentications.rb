class CreateAuthentications < ActiveRecord::Migration[5.1]
    def change
        create_table :authentications do |t|
            t.string :uid
            t.string :token
            t.string :provider
            t.references :users
            t.timestamps
        end
    end
end
