require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
  describe 'GET #index' do
    context 'with params[:letter]' do 
      it "populates an array category starting with the letter" do
        main_dish = create(:category, name: "Main Dish")
        desert = build(:category, name: "Desert")
        get :index, params: { letter: 'M'}
        expect(assigns(:categories)).to match_array([main_dish])
      end

      it "renders the :index template" do
        get :index, params: { letter: 'M'}
        expect(response).to render_template :index
      end
    end

    context 'without params [:letter]' do
      it "populates an array of all categories" do
        main_dish = create(:category, name: "Main Dish")
        desert = create(:category, name: "Desert")
        get :index
        expect(assigns(:categories)).to match_array([main_dish, desert])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "GET #show" do
    it "assigns the requested category to @category" do
      category = create(:category)
      get :show, params: { id: category } 
      expect(assigns(:category)).to eq category
    end

    it "renders the :show template" do
      category = create(:category)
      get :show, params: { id: category }
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it "assigns a new Category to @category" do
      get :new
      expect(assigns(:category)).to be_a_new(Category)
    end

    it "renders the :new template" do
      get :new
      expect(:response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it "assigns the requested category to @category" do
      category = create(:category)
      get :edit, params: { id: category }
      expect(assigns(:category)).to eq category
    end

    it "renders the :edit template" do
      category = create(:category)
      get :edit, params: { id: category }
      expect(response).to render_template :edit
    end
  end

  describe 'PACTH #update' do
    before :each do 
      @category = create(:category)
    end

    context "with valid attributes" do
      it "locates the requested @category" do
        patch :update, params: { id: @category, category: attributes_for(:category) }
        expect(assigns(:category)).to eq @category
      end

      it "changes @category's attributes" do
        patch :update, params: { id: @category, category: attributes_for(:category, name: 'Main Dish') }
        @category.reload
        expect(@category.name).to eq('Main Dish')
      end

      it "redirects to the category" do 
        patch :update, params: { id: @category, category: attributes_for(:category) }
        expect(response).to redirect_to category_path(@category)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the updated category in the database' do
        patch :update, params: { id: @category, category: attributes_for(:invalid_category, category: 'Main Dish') }
        expect(@category.name).not_to eq('Main Dish')
      end

      it 're-renders the edit template' do
        patch :update, params: { id: @category, category: attributes_for(:invalid_category)}
        expect(assigns(:category)).to eq @category
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @category = create(:category)
    end

    it "deletes the category from the database" do
      expect{
        delete :destroy, params: { id: @category}
      }.to change(Category, :count).by(-1)
    end

    it "redirects to menus#index" do
      delete :destroy, params: { id: @category }
      expect(response).to redirect_to category_url
    end
  end
end