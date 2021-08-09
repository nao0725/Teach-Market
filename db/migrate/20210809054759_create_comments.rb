class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :comment_content
      t.references :user
      t.references :article, foreign_key: true

      t.timestamps
    end
  end
end
