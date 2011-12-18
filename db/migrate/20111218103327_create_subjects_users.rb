class CreateSubjectsUsers < ActiveRecord::Migration
  def change
    create_table :subjects_users, :id => false do |t|
      t.integer :user_id
      t.integer :subject_id
    end
  end
end
