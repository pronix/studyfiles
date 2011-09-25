class CreateNovelties < ActiveRecord::Migration
  def change
    create_table :novelties do |t|
      t.text :text
      t.boolean :main
      t.string :title


      t.timestamps
    end
  end
end
