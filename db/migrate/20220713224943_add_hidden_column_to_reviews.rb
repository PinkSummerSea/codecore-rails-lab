class AddHiddenColumnToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :hidden, :boolean, default: false
  end
end
