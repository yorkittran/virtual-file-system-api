class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
