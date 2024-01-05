# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:product) { create(:product) }
  let(:category) { product.category }
  let(:user) { create(:user) }
  before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil } }

  describe '#index' do
    it 'renders index template' do
      get :index, params: { user_id: user.id, category_id: category.id }

      expect(response).to render_template('index')
    end
  end

  describe '#show' do
    it 'returns product page' do
      get :show, params: { id: product.id, category_id: category.id, user_id: user.id }, format: :html

      expect(assigns(:product)).to eq(product)
    end
  end

  describe '#edit' do
    it 'assigns the requested product as @product' do
      get :edit, params: { id: product.id, category_id: category.id, user_id: product.user_id }
      expect(assigns(:product)).to eq(product)
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      it 'updates product' do
        put :update,
            params: { id: product.id, product: { title: 'test' }, category_id: category.id, user_id: product.user_id }

        expect(response).to redirect_to category_product_path(category, product)
      end
    end

    context 'with invalid attributes' do
      it 'does not update product' do
        put :update,
            params: { id: product.id, product: { title: nil }, category_id: category.id, user_id: product.user_id }

        expect(response).to render_template('edit')
      end
    end
  end
end
