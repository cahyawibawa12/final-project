class CategoriesController < ApplicationController
  before_action :set_category, only: %i[ show edit update destroy ]
  
  def show
  end

  def new
    @category = Category.new
  end

  def index
    if params[:letter].nil?
      @categories = Category.all
    else
      @mcategories = Category.by_letter(params[:letter])
    end
    # @categories = params[:letter].nil? ? Category.all : Category.by_letter(params[:letter])
  end

  def edit
  end

  def update
    @category = Category.find_by(id: params[:id])

    @category.update(params.require(:category).permit(:name))
    if @category.save
      redirect_to category_path(@category)
    else
      render :edit, status: 422
    end
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to category_url(@category), notice: "Category was successfully created." }
        format.json { render :index, status: :created, location: @category }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    redirect_to category_path(@category)
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
