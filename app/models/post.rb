require 'taggable'

class Post < ActiveRecord::Base
  include ::Taggable
  default_scope order('created_at DESC')
  attr_accessible :body
end
