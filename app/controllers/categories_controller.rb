class CategoriesController < ApplicationController
  def show
    @category = Category.find_by(id: params[:id])
  end

  def new
    @category = Category.new
  end

  def index
    @categories = params[:letter].nil? ? Category.all : Category.by_letter(params[:letter])
  end

  def edit
    @category = Category.find_by(id: params[:id])
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
    
  end

  def destroy
    @category = Category.find_by(id: params[:id])
    @category.destroy
    redirect_to category_path(@category)
  end
end
