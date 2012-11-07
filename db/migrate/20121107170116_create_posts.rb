class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :body

      t.timestamps
    end

    add_column :taggings, :post_id, :integer
  end

  def down
    drop_table :posts
    remove_column :taggings, :post_id
  end

end
