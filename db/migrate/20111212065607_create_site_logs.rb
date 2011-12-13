class CreateSiteLogs < ActiveRecord::Migration
  def change
    create_table :site_logs do |t|
      t.integer :user_id, :relation_id, :name
      t.string :action, :relation_type
      t.timestamps
    end
    update "ALTER TABLE \"site_logs\" ADD \"path\" LTREE NOT NULL DEFAULT ''"
  end
end
