class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :name, :email, :type
      t.text :message
      t.timestamps
    end
  end
end
