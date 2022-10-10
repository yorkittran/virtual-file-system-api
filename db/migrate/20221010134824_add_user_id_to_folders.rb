class AddUserIdToFolders < ActiveRecord::Migration[7.0]
  def change
    add_reference :folders, :user, null: false, foreign_key: true, after: :id
  end
end
