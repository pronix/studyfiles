class CreateSubjects < ActiveRecord::Migration
  create_table :subjects do |t|
    t.string :name
    t.string :abbreviation
    t.integer :section_id
    t.integer :rating
    t.timestamps
  end
end
