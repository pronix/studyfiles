class RaitingUserRelation < ActiveRecord::Migration
   def change
    #отношение рейтингов к пользователю
    create_table :votes, :id => false do |t|
      t.integer :user_id
      t.integer :document_id
      t.boolean :type, :default => true
    end

  end
end
