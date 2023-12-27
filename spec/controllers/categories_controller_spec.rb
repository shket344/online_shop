# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  let(:category) { create(:category) }
  let(:user) { create(:user) }
  before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

  describe '#index' do
    it 'renders index template' do
      get :index

      expect(response).to render_template('index')
    end
  end

  describe '#new' do
    it 'assigns a new category as @category' do
      get :new, params: { user_id: user.id }
      expect(assigns(:category)).to be_a_new(Category)
    end
  end

  describe '#create' do
    let(:category_params) { attributes_for(:category, user_id: user.id) }

    context 'with valid attributes' do
      it 'creates new category' do
        post :create, params: { user_id: user.id, category: category_params }

        category = Category.find_by(title: category_params[:title])
        expect(response).to redirect_to user_category_products_path(user, category)
      end
    end

    context 'with invalid attributes' do
      it 'does not create new category' do
        post :create, params: { user_id: user.id, category: { title: nil } }

        expect(response).to render_template('new')
      end
    end
  end

  describe '#edit' do
    it 'assigns the requested category as @category' do
      get :edit, params: { user_id: category.user_id, id: category.id }
      expect(assigns(:category)).to eq(category)
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      it 'updates category' do
        put :update, params: { user_id: category.user_id, id: category.id, category: { title: 'test' } }

        expect(response).to redirect_to category_products_path(category)
      end
    end

    context 'with invalid attributes' do
      it 'does not update category' do
        put :update, params: { user_id: category.user_id, id: category.id, category: { title: nil } }

        expect(response).to render_template('edit')
      end
    end
  end

  describe '#destroy' do
    it 'destroys category' do
      delete :destroy, params: { user_id: category.user_id, id: category.id }

      expect(response).to have_http_status(:see_other)
    end
  end
end
