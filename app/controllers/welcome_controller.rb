class WelcomeController < ApplicationController
  def index
    @items = (Image.all + Post.all).sort{|k,v|
      v.created_at <=> k.created_at
    }[0...5]
  end
end
