class RemoveImageIdFromTag < ActiveRecord::Migration
  def up
    remove_column :tags, :image_id
  end

  def down
    add_column :tags, :image_id
  end
end
