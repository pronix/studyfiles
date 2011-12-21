class UsersDownloads < ActiveRecord::Migration
  def change
    create_table :users_downloads, :id => false do |t|
      t.integer :user_id, :document_id
    end
  end
end
