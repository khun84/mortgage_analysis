class ChangeUsersIdColumnName < ActiveRecord::Migration[5.1]
  def up
      rename_column :authentications, :users_id, :user_id
  end

    def down
        rename_column :authentications, :user_id, :users_id
    end
end
