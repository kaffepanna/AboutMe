class Tagging < ActiveRecord::Base
  attr_accessible :image_id, :tag_id
  belongs_to :tag
  belongs_to :image
end
