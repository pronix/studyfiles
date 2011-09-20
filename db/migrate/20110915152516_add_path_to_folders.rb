class AddPathToFolders < ActiveRecord::Migration
  def self.up
    update "ALTER TABLE \"folders\" ADD \"path\" LTREE NOT NULL DEFAULT 'Top'"
  end

  def self.down
    update "ALTER TABLE \"folders\" DROP \"path\""
  end
end
