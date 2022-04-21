class CategoriesController < ApplicationController
  def show
  end

  def new
    @category = Category.new
  end

  def index
    @categories = Category.all
  end

  def edit
  end

  def update
  end

  def create
    
  end

  def destroy
  end
end
