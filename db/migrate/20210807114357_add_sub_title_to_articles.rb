class AddSubTitleToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :sub_title, :string
  end
end
