class CreateSiteLogs < ActiveRecord::Migration
  def change
    create_table :site_logs do |t|
      t.integer :user_id, :folder_id
      t.string :action
      t.timestamps
    end
  end
end
