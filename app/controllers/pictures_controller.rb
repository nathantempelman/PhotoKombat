class PicturesController < ApplicationController
  before_action :set_category, except: :new
  before_action :set_picture, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin, only: [:edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def show
    respond_to do |format|
      format.json
    end
  end

  def new
    @category = Category.find_by(handle: params[:handle])
    @picture = Picture.new
  end

  def edit
  end

  def create
    @picture = @category.pictures.build(picture_params)
    @picture.user = current_user if signed_in?

    respond_to do |format|
      if @picture.save
        format.html { redirect_to [@category, @picture], notice: 'Picture was successfully created.' }
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
        format.html { redirect_to [@category, @picture], notice: 'Picture was successfully updated.' }
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
      format.html { redirect_to compare_category_path(@category), notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_category
    @category = Category.find_by(handle: params[:category_handle])
  end

  def set_picture
    @picture = @category.pictures.find(params[:id])
  end

  def picture_params
    params.require(:picture).permit(:name, :url, :user_id, :rating)
  end
end
