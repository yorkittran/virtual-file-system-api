class AddAncestryToFolders < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :ancestry, :string, after: :name
    add_index :folders, :ancestry
  end
end
