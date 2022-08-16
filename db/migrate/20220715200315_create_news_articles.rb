class CreateNewsArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :news_articles do |t|
      t.string :title
      t.text :description
      t.timestamp :published_at
      t.timestamps
    end
  end
end
