class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.integer :power

      t.timestamps
    end
    add_index :users, :name, unique: true
  end
end
