# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe CartsController, type: :controller do
  let(:cart) { create(:cart) }
  let(:user) { subject.current_user }

  before do
    create(:order, cart: cart)
  end

  login_user

  describe '#index' do
    it 'renders index template' do
      get :index, params: { user_id: user.id }

      expect(response).to render_template('index')
    end
  end

  describe '#show' do
    it 'returns cart page' do
      get :show, params: { id: cart.id, user_id: user.id }, session: { cart_id: cart.id }

      expect(assigns(:cart)).to eq(cart)
    end
  end

  describe '#make_order' do
    it 'makes order' do
      get :make_order, params: { id: cart.id, user_id: user.id }, session: { cart_id: cart.id }

      expect(response).to redirect_to('/')
    end
  end

  describe '#retry_order' do
    let(:declined_cart) { create(:cart, state: :declined) }

    before do
      create(:order, cart: declined_cart, status: :declined)
    end

    it 'retries order' do
      get :retry_order, params: { id: declined_cart.id, user_id: user.id }

      expect(response).to redirect_to user_carts_path(user.id)
    end
  end

  describe '#repeat_order' do
    let(:approved_cart) { create(:cart, state: :approved) }

    before do
      create(:order, cart: approved_cart, status: :approved)
    end

    it 'repeats order' do
      get :repeat_order, params: { id: approved_cart.id, user_id: user.id }

      expect(response).to redirect_to user_carts_path(user.id)
    end
  end
end
