class AddDefaultToRaiting < ActiveRecord::Migration
  def up
    update 'ALTER TABLE "documents" ALTER COLUMN "raiting" SET DEFAULT 0'
  end

  def down
    update 'ALTER TABLE "documents" ALTER COLUMN "raiting" SET DEFAULT NULL'
  end
end
