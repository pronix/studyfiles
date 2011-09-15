class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.text :text
      t.integer :from_user_id

      t.timestamps
    end
  end
end
