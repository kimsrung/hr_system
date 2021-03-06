class DeviseCreateEmployers < ActiveRecord::Migration[5.1]
  def change
    create_table :employers do |t|
      ## Database authenticatable
      t.string :name
      t.text :description
      t.references :company,        foreign_key: true
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet     :current_sign_in_ip
      t.inet     :last_sign_in_ip

      t.timestamps null: false
    end

    add_index :employers, :email,                unique: true
    add_index :employers, :reset_password_token, unique: true
    # add_index :employers, :confirmation_token,   unique: true
    # add_index :employers, :unlock_token,         unique: true
  end
end
