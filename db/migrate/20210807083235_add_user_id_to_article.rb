class AddUserIdToArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :user_id, :string
  end
end
