class SubjectsUniversities < ActiveRecord::Migration
  def change
    create_table :subjects_universities, :id => false do |t|
      t.integer :university_id
      t.integer :subject_id
    end
  end
end
