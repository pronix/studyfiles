class AddSubjectIdToFolder < ActiveRecord::Migration
  def change
    add_column :folders, :subject_id, :integer
  end
end
