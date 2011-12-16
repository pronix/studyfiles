class CreateImagePreviews < ActiveRecord::Migration
  def change
    create_table :image_previews do |t|

      t.timestamps
    end
  end
end
