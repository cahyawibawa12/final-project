class MenusController < ApplicationController
  def index
    if params[:letter].nil?
      @menus = Menu.all
    else
      @menus = Menu.by_letter(params[:letter])
    end
    # @menus = params[:letter].nil? ? Menu.all : Menu.by_letter(params[:letter])
  end

  def new
    @menu = Menu.new
  end

  def edit
    @menu = Menu.find_by(id: params[:id])
  end

  def update
    @menu = Menu.find_by(id: params[:id])

    @menu.update(params.require(:menu).permit(:name))
    if @menu.save
      redirect_to menus_path(@menu)
    else
      render :edit, status: 422
    end
  end

  def show
    @menu = Menu.find_by(id: params[:id])
  end

  def destroy
    @menu = Menu.find_by(id: params[:id])
    @menu.destroy
    redirect_to menus_path
  end

  def create
    
  end
end
