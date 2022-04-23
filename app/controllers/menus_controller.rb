class MenusController < ApplicationController
  before_action :set_menu, only: %i[ show edit update destroy ]
  
  def index
    if params[:letter].nil?
      @menus = Menu.all
    else
      @menus = Menu.by_letter(params[:letter])
    end
  end

  def new
    @menu = Menu.new
  end

  def edit
  end

  def update
    
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to menu_url(@menu), notice: "Menu was successfully updated." }
        format.json { render :index, status: :ok, location: @menu }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def destroy
    @menu.destroy
    redirect_to menus_path
  end

  def create
    @menu = Menu.new(menu_params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to menu_url(@menu), notice: "menu was successfully created." }
        format.json { render :index, status: :created, location: @menu }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  
  def menu_params
      params.require(:menu).permit(:name, :description, :price, :category_id)
  end

  def set_menu
    @menu = Menu.find(params[:id])
  end
end
