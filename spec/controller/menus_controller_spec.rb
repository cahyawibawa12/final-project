require 'rails_helper'

RSpec.describe MenusController, :type => :controller do
  describe 'GET #index' do
    context 'with params[:letter]' do 
      it "populates an array menus starting with the letter" do
        nasi_uduk = create(:menu, name: "Nasi Uduk")
        ketoprak = build(:menu, name: "Ketoprak")
        get :index, params: { letter: 'N'}
        expect(assigns(:menus)).to match_array([nasi_uduk])
      end

      it "renders the :index template" do
        get :index, params: { letter: 'N'}
        expect(response).to render_template :index
      end
    end

    context 'without params [:letter]' do
      it "populates an array of all menus" do
        cartegory = Category.create(
          name: "dish"
        )
        
        menu1 = Menu.create(
          name: "Nasi Goreng Ayam",
          description: "test",
          price: 10000.0,
          category_id: 1
        )

         menu2 = Menu.create(
          name: "Soto Ayam",
          description: "test",
          price: 10000.0,
          category_id: 1
        )
        # nasi_goreng_ayam = create(:menu, name: "Nasi Goreng Ayam")
        # tipat_cantok = create(:menu, name: "Tipat Cantok")
        get :index
        expect(assigns(:menus)).to match_array([menu1, menu2])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested menu to @menu" do
      menu = create(:menu)
      get :show, params: { id: menu } 
      expect(assigns(:menu)).to eq menu
    end

    it "renders the :show template" do
      menu = create(:menu)
      get :show, params: { id: menu }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new Menu to @menu" do
      get :new
      expect(assigns(:menu)).to be_a_new(Menu)
    end

    it "renders the :new template" do
      get :new
      expect(:response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested menu to @menu" do
      menu = create(:menu)
      get :edit, params: { id: menu }
      expect(assigns(:menu)).to eq menu
    end

    it "renders the :edit template" do
      menu = create(:menu)
      get :edit, params: { id: menu }
      expect(response).to render_template :edit
    end
  end

  describe 'PACTH #update' do
    before :each do 
      @menu = create(:menu)
    end

    context "with valid attributes" do
      it "locates the requested @menu" do
        patch :update, params: { id: @menu, menu: attributes_for(:menu) }
        expect(assigns(:menu)).to eq @menu
      end

      it "changes @menu's attributes" do
        patch :update, params: { id: @menu, menu: attributes_for(:menu, name: 'Nasi Goreng Ayam') }
        @menu.reload
        expect(@menu.name).to eq('Nasi Goreng Ayam')
      end

      it "redirects to the category" do 
        patch :update, params: { id: @menu, menu: attributes_for(:menu) }
        expect(response).to redirect_to menu_url(@menu)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the updated menu in the database' do
        patch :update, params: { id: @menu, menu: attributes_for(:invalid_menu, name: 'Nasi Gorang Ayam', price: "Test") }
        expect(@menu.name).not_to eq('Nasi Gorang Ayam')
      end

      it 're-renders the edit template' do
        patch :update, params: { id: @menu, menu: attributes_for(:invalid_menu)}
        expect(assigns(:menu)).to eq @menu
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @menu = create(:menu)
    end

    it "deletes the menu from the database" do
      expect{
        delete :destroy, params: { id: @menu}
      }.to change(Menu, :count).by(-1)
    end

    it "redirects to menus#index" do
      delete :destroy, params: { id: @menu }
      expect(response).to redirect_to menus_url
    end
  end
end