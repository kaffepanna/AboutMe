class Image < ActiveRecord::Base
  attr_accessible :caption, :original_data, :thumb_data
end
