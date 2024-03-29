class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :user_id, :folder_id, :university_id, :subject_id
      t.string :name, :sha
      t.boolean :item_processed, :default => false
      t.boolean :tmp, :default => true, :null => false
      t.text :description, :txt_doc
      t.integer :rating, :null => false, :default => 0

      t.integer :item_file_size
      t.string :item_file_name, :item_content_type
      t.datetime :item_updated_at

      t.timestamps
    end
  end
end
