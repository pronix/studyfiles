class AddUniversityIdToFolder < ActiveRecord::Migration
  def change
    add_column :folders, :university_id, :integer
  end
end
