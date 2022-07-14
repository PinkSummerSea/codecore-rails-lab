class AddImageFileColumnToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :image_file, :text
  end
end
