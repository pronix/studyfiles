class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :raiting
      t.timestamps
    end
  end
end
