class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.string :name
      t.text :description
      t.integer :user_id, :university_id, :subject_id
      t.timestamps
    end
    update "ALTER TABLE \"folders\" ADD \"path\" LTREE NOT NULL DEFAULT ''"
  end
end
