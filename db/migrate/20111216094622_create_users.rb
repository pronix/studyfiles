class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable
      t.string :name
      t.boolean :subscriber

      t.string :avatar_file_name, :avatar_content_type
      t.integer :avatar_file_size
      t.datetime :avatar_updated_at
      t.timestamps
    end
    add_index :users,      :email,                :unique => true
    add_index :users,      :reset_password_token, :unique => true
  end
end
