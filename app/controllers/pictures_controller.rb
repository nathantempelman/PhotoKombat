class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  def index
    @pictures = Picture.all
  end

  def show
  end

  def new
    @picture = Picture.new
  end

  def edit
  end

  def create
    @picture = Picture.new(picture_params)
    set_user_on_picture

    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def compare
    # count query once, save the number
    @count = Picture.count
    return if @count < 2
    @pic_a = Picture.offset(rand(@count)).first
    @pic_b = Picture.offset(rand(@count)).first
    until @pic_a.id != @pic_b.id do
      @pic_b = Picture.offset(rand(@count)).first
    end
  end

  def compare_submit
    # Note variables are snake cased, not camel cased
    pic_a = Picture.find(params[:winner_id])
    pic_b = Picture.find(params[:loser_id])
    pic_a.beats(pic_b)
    redirect_to compare_pictures_url # Or wherever
  end

  private

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:name, :url, :user_id, :rating)
  end

  def set_user_on_picture
    if signed_in?
      @picture.user = current_user
    end
  end

end
