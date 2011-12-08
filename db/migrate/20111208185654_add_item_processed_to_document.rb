class AddItemProcessingToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :item_processed, :boolean, :default => false
  end
end
