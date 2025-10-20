class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, default: "user"
      t.string :password_digest
      t.string :email
      t.string :token
      t.string :google_id
      t.integer :role, default: 0

      t.timestamps
    end
  end
end
