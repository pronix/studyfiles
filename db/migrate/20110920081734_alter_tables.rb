class AlterTables < ActiveRecord::Migration
  def up
    change_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.encryptable
      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps
    end

    add_index :users,      :email,                :unique => true
    add_index :users,      :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true

    add_column :users,     :avatar_file_name,     :string
    add_column :users,     :avatar_content_type,  :string
    add_column :users,     :avatar_file_size,     :integer
    add_column :users,     :avatar_updated_at,    :datetime
    add_column :users,     :name,                 :string
    add_column :users,     :subscriber,           :boolean

    add_column :documents, :item_file_name,       :string
    add_column :documents, :item_content_type,    :string
    add_column :documents, :item_file_size,       :integer
    add_column :documents, :item_updated_at,      :datetime
    add_column :documents, :user_id,              :integer
    add_column :documents, :name,                 :string
    add_column :documents, :description,          :boolean
    add_column :documents, :sha,                  :string
    add_column :folders,   :path_name,            :string
    
    add_index :delayed_jobs, [:priority, :run_at], :name => 'delayed_jobs_priority'
  end

  def down
    raise ActiveRecord::IrreversibleMigration

    remove_column :users,     :avatar_file_name
    remove_column :users,     :avatar_content_type
    remove_column :users,     :avatar_file_size
    remove_column :users,     :avatar_updated_at
    remove_column :users,     :name
    remove_column :users,     :subscriber

    remove_column :documents, :avatar_file_name
    remove_column :documents, :avatar_content_type
    remove_column :documents, :avatar_file_size
    remove_column :documents, :avatar_updated_at
    remove_column :documents, :name
    remove_column :documents, :description
    remove_column :documents, :user_id
    remove_column :documents, :sha
    remove_column :folders,   :path_name
  end
end
