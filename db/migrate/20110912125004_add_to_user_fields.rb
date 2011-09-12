class AddToUserFields < ActiveRecord::Migration
  def up
    add_column :users, :avatar_file_name,    :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size,    :integer
    add_column :users, :avatar_updated_at,   :datetime

    add_column :users, :name,                :string
    add_column :users, :subscriber,          :boolean
  end

  def down
    remove_column :users, :avatar_file_name
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_updated_at
    remove_column :users, :name
    remove_column :users, :subscriber
  end
end
