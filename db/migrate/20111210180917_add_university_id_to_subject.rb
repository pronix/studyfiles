class AddUniversityIdToSubject < ActiveRecord::Migration
  def change
    add_column :subjects, :university_id, :integer
  end
end
