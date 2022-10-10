class CreateFiles < ActiveRecord::Migration[7.0]
  def change
    create_table :files do |t|
      t.references :folder, index: true, foreign_key: true, null: false
      t.string :name, null: false
      t.string :data

      t.timestamps
    end
  end
end
