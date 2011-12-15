class AddSubjectIdToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :subject_id, :integer
  end
end
