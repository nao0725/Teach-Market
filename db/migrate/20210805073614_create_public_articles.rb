class CreatePublicArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :public_articles do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
