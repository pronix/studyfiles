# -*- coding: utf-8 -*-
# This file should be migrated after all files
class Ltree < ActiveRecord::Migration
  def up
    # для постгреса 9.1 используем механизм расширений
    update "CREATE EXTENSION ltree"
    # update "ALTER TABLE \"folders\" ADD \"path\" LTREE NOT NULL DEFAULT ''"
  end

  def down
    # update "ALTER TABLE \"folders\" DROP \"path\""
    update "DROP EXTENSION ltree"
  end
end
