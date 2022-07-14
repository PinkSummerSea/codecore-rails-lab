class RemoveImageUrlColumnFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :image_url, :text
  end
end
