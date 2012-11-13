require 'taggable'

class Post < ActiveRecord::Base
  include ::Taggable
  default_scope order('created_at DESC')
  attr_accessible :body
  validate :starts_with_heading

  def starts_with_heading
    unless RDiscount.new(self.body).to_html.lines.first =~ /^<h1>/
      errors.add(:body, "Needs to start with <h1>")
    end
  end
end
