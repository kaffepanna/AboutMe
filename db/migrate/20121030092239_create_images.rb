class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :caption
      t.binary :thumb_data
      t.binary :original_data

      t.timestamps
    end
  end
end
