class AddBookmarkCountToBookmark < ActiveRecord::Migration[5.2]
  def change
    add_column :bookmarks, :bookmark_count, :integer, null: false, default: 0
  end
end
