module Taggable
  extend ActiveSupport::Concern
  included do 
    has_many :taggings, dependent: :destroy, as: :owner
    has_many :tags, through: :taggings
    attr_accessible :tag_names
  
    after_save :assign_tags
  end
  
  attr_reader :tag_names

  def tag_names
    @tag_names ||= self.tags.map(&:name).join(' ')
  end

  def tag_names=(t)
    @tag_names = t
  end

  def assign_tags
    self.tags = self.tag_names.split(/\s+/).map do |name|
      Tag.find_or_create_by_name(name)
    end
  end
end


