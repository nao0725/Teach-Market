class CreateManuals < ActiveRecord::Migration[5.2]
  def change
    create_table :manuals do |t|
      t.string :name
      t.string :manual_image_id
      t.string :sub_title
      t.string :title
      t.text   :text

      t.timestamps
    end
  end
end
