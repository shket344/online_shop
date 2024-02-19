# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe OrdersController, type: :controller do
  let(:cart) { create(:cart) }
  let(:user) { subject.current_user }
  let(:product) { create(:product, quantity: 5) }
  let(:order) { create(:order, cart: cart, user: user) }
  let(:order_params) { { id: order_id, user_id: user.id, product_id: product.id, quantity: 1 } }

  login_user

  describe '#update_order' do
    let(:order_id) { order.id }

    it 'updates order' do
      post :update_order, params: order_params,
                          session: { cart_id: cart.id }

      expect(response).to redirect_to user_cart_path(user.id, cart)
    end
  end

  describe '#add' do
    context 'when order present' do
      let(:order_id) { order.id }

      it 'adds order' do
        post :add, params: order_params,
                   session: { cart_id: cart.id }

        expect(response).to redirect_to user_cart_path(user.id, cart)
      end
    end

    context 'when no order' do
      let(:order_id) { 0 }

      it 'creates order' do
        expect { post :add, params: order_params, session: { cart_id: cart.id } }.to change { Order.count }.by(1)
      end
    end
  end

  describe '#remove_order' do
    let(:order_id) { order.id }

    it 'removes order' do
      get :remove_order, params: order_params,
                         session: { cart_id: cart.id }

      expect(response).to redirect_to user_cart_path(user.id, cart)
    end
  end
end
