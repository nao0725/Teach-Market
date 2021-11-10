class AddArticleStatusToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :article_status, :integer, null: false, default: 0
  end
end
