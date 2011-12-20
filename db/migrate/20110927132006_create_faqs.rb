class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.string :question
      t.text :answer
      t.timestamps
    end
    update "ALTER TABLE \"faqs\" ADD \"path\" LTREE NOT NULL DEFAULT ''"
  end
end
