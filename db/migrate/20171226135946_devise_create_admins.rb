class DeviseCreateAdmins < ActiveRecord::Migration[5.1]
  def change
    create_table :admins do |t|
      t.string :email
      t.string :encrypted_password
      t.timestamps null: false
    end

    add_index :admins, :email,  unique: true
  end
end
