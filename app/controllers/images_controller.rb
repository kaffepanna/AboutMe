class ImagesController < ApplicationController
  def index
    @images = Image.find :all
    respond_to do | format|
      format.html 
      format.json { render json: @images }
    end
  end

  def thumb
    @image = Image.select('images.thumb_data').find(params[:id])
    respond_to do |format|
      format.png { send_data @image.thumb_data, type: :png, disposition: 'inline' }
    end
  end

  def original
    @image = Image.select('images.original_data').find(params[:id])
    respond_to do |format|
      format.png { send_data @image.original_data, type: :png, disposition: 'inline' }
    end
  end

  def rotate
    @image = Image.select('*').find(params[:id])
    @image.rotate!
    respond_to do |format|
      if @image.save
        format.html {  redirect_to @image, notice: 'Image rotated' }
        format.json { render json: @image, status: :rotated, location: @image }
      else
        format.html {  redirect_to @image, notice: 'Error rotating image' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @image }
    end
  end

  def new
    @image = Image.new

    respond_to do |format|
      format.html
      format.json { render json: @image }
    end
  end

  def edit
    @image = Image.find(params[:id])
  end

  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image uploded' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: 'new' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @image = Image.find(params[:id])
    respond_to do |format|
      if @best.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image updated' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end
end
