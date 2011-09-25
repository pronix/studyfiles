class RenameColumn < ActiveRecord::Migration
  def up
    remove_column :messages, :from_user_id
    add_column :messages, :to_user_id, :integer
  end

  def down
    add_column :messages, :from_user_id, :integer
    remove_column :messages, :to_user_id
  end
end
