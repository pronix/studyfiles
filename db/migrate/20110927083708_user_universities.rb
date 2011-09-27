class UserUniversities < ActiveRecord::Migration
  def change
    #отношение пользователей и университетов
    create_table :user_universities, :id => false do |t|
      t.integer :user_id
      t.integer :university_id
    end
  end
end
