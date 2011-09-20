class AddPathNameToFolder < ActiveRecord::Migration
   def up
    add_column :folders, :path_name, :string
  end

  def down
    remove_column :folders, :path_name
  end
end
