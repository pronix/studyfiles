class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :document_id
      t.integer :user_id
      t.boolean :vote_type
      t.integer :grade, :default => 1

      t.timestamps
    end
  end
end
