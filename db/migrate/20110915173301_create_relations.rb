class CreateRelations < ActiveRecord::Migration
  def change
    #отношение университетов и предметов
    create_table :university_subjects, :id => false do |t|
      
      t.integer :university_id
      t.integer :subject_id

    end

    #отношение предметов и папок
    create_table :subject_folders, :id => false do |t|

      t.integer :folder_id
      t.integer :subject_id

    end

    #отношение предметов и файлов
    create_table :subject_documents, :id => false do |t|

      t.integer :document_id
      t.integer :subject_id

    end
  end
end
