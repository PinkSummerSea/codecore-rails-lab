class AddViewCountColumnToNewsArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :news_articles, :view_count, :integer, default: 0
  end
end
