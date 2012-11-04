require 'free-image'
require 'stringio'

class Image < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  default_scope select('images.id, images.caption')

  attr_accessible :caption, :image_file, :tag_names
  attr_protected :original_data, :thumb_data
  attr_accessor :tag_names

  after_save :assign_tags

  validates_presence_of :caption, :tag_names 
  validates :original_data, presence: true, on: :create
  validates :thumb_data, presence: true, on: :create
  #validates :image_file, presence: true, on: :create

  def tag_names
    @tag_names ||= tags.map(&:name).join(' ')
  end

  def assign_tags
    self.tags = self.tag_names.split(/\s+/).map do |name|
      Tag.find_or_create_by_name(name)
    end
  end

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

  def rotate!
    original_string = StringIO.new(self.original_data)
    thumb_string = StringIO.new("")
    original_io = FreeImage::IO.new(original_string)
    FreeImage::Bitmap.open(original_io) do |image|
      rotated = image.rotate(90, FreeImage::RGBQuad.create(0,0,0,0))
      rotated.make_thumbnail 240 do |thumb|
        thumb_io = FreeImage::IO.new(thumb_string)
        thumb.save(thumb_io, :png)
      end  
      original_string.string=""
      rotated.save(original_io, :png)
    end
    self.original_data = original_string.string
    self.thumb_data    = thumb_string.string
  end
end

