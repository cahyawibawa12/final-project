class Api::V1::MenusController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :set_menu, only: %i[ show edit update destroy ]
  
  def index
    if params[:letter].nil?
      @menus = Menu.all
    else
      @menus = Menu.by_letter(params[:letter])
    end
    render json: @menus
  end

  def new
    @menu = Menu.new
  end

  def edit
  end

  def update
    @menu.update(menu_params)
    @menu.save
    render json: @menu
  end

  def show
  end

  def destroy
    @menu.destroy
    redirect_to menus_path
    render json: @menu, status: 200
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.save
    render json: @menu
  end

  private
  
  def menu_params
      params.require(:menu).permit(:name, :description, :price, :category_id)
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end
end
