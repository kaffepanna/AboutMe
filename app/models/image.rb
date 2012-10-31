require 'free-image'
require 'stringio'

class Image < ActiveRecord::Base
  default_scope select('images.id, images.caption')

  attr_accessible :caption, :image_file
  attr_protected :original_data, :thumb_data

  def image_file=(file)
    original_string = StringIO.new("")
    thumb_string    = StringIO.new("")
    FreeImage::Bitmap.open(file.tempfile.open) do |image|
      image.make_thumbnail 240 do |thumb|
        thumb_io = FreeImage::IO.new(thumb_string)
        thumb.save(thumb_io, :png)
      end

      original_io = FreeImage::IO.new(original_string)
      image.save(original_io, :png)
    end

    self.original_data = original_string.string
    self.thumb_data    = thumb_string.string
  end 
end
