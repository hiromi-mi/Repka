class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.string :title
      t.string :teacher
      t.integer :year
      t.string :kind
      t.text :data

      t.timestamps
    end
  end
end
