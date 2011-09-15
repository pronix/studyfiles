class AddPaperclipToDocuments < ActiveRecord::Migration
  def up
    add_column :documents, :item_file_name,    :string
    add_column :documents, :item_content_type, :string
    add_column :documents, :item_file_size,    :integer
    add_column :documents, :item_updated_at,   :datetime
    add_column :documents, :user_id,           :integer
    add_column :documents, :name,              :string
    add_column :documents, :description,       :boolean
    add_column :documents, :sha,               :string
  end

  def down
    remove_column :documents, :avatar_file_name
    remove_column :documents, :avatar_content_type
    remove_column :documents, :avatar_file_size
    remove_column :documents, :avatar_updated_at
    remove_column :documents, :name
    remove_column :documents, :description
    remove_column :documents, :user_id
    remove_column :documents, :sha
  end
end
