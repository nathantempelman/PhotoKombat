class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :compare, :top]

  def index
    @categories = Category.all
  end

  def show
    @pictures = @category.pictures
  end

  def compare
    # count query once, save the number
    @count = @category.pictures.count
    return if @count < 2
    @pic_a = @category.pictures.offset(rand(@count)).first
    @pic_b = @category.pictures.offset(rand(@count)).first
    until @pic_a.id != @pic_b.id do
      @pic_b = @category.pictures.offset(rand(@count)).first
    end
  end

  def top
    @pictures = @category.pictures.order(rating: :desc).limit(100)
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @category = Category.find_by(handle: params[:handle])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
