class CreateReadNotifications < ActiveRecord::Migration
  def change
    create_table :read_notifications do |t|
      t.integer :user_id, :notification_id
      t.string :notification_type
      t.timestamps
    end
  end
end
