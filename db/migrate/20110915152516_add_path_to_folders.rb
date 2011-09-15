class AddPathToFolders < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE \"folders\" ADD \"path\" LTREE NOT NULL DEFAULT 'Top'"
  end

  def self.down
    execute "ALTER TABLE \"folders\" DROP \"path\""
  end
end
