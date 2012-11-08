class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :taggings, dependent: :destroy
  has_many :images, through: :taggings, source: :owner, source_type: 'Image'
  has_many :posts, through: :taggings, source: :owner, source_type: 'Post'
end
