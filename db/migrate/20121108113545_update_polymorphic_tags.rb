class UpdatePolymorphicTags < ActiveRecord::Migration
  def up
    remove_column :taggings, :image_id
    remove_column :taggings, :post_id
    add_column :taggings, :owner_id, :integer
    add_column :taggings, :owner_type, :string
  end

  def down
  end
end
