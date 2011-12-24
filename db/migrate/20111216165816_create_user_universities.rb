class CreateUserUniversities < ActiveRecord::Migration
  def change
    create_table :user_universities do |t|
      t.integer :user_id, :university_id, :null => false
      t.integer :rank
      t.timestamps
    end
  end
end
