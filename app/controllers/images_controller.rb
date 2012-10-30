class ImagesController < ApplicationController
  def index

    respond_to do | format|
      format.html { render text: "<h1>Images</h1>", layout: true }
    end
  end
end
