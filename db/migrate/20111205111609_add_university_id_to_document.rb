class AddUniversityIdToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :university_id, :integer
  end
end
