class Api::V1::CategoriesController < ApplicationController
  protect_from_forgery with: :null_session
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
      @categories = Category.by_letter(params[:letter])
    end
    render json: @categories
  end

  def edit
  end

  def update
    @category.update(category_params)
    @category.save
    render json: @category
  end

  def create
    @category = Category.new(category_params)
    @category.save
    render json: @category
  end

  def destroy
    @category.destroy
    redirect_to category_path(@category)
    render json: @category, status: 200
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
