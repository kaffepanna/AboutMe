require 'taggable'

class Post < ActiveRecord::Base
  include ::Taggable
  attr_accessible :body
end
