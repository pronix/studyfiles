class CreateUniversities < ActiveRecord::Migration
  def change
    create_table :universities do |t|
      t.string :name, :abbreviation, :city
      t.integer :rating, :default => 0
      t.timestamps

      t.string :logo_file_name, :logo_content_type
      t.integer :logo_file_size
      t.datetime :logo_updated_at
    end
  end
end
