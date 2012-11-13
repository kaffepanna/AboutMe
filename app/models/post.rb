require 'taggable'

class Post < ActiveRecord::Base
  include ::Taggable
  default_scope order('created_at DESC')
  attr_accessible :body
  validate :starts_with_heading

  def starts_with_heading
    begin
      markdown(self)
      return true
    rescue
      errors.add(:body, "Needs to start with <h1>")
      return false
    end
  end
end
