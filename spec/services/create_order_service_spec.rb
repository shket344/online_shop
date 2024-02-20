# frozen_string_literal: true

require 'rails_helper'

describe CreateOrderService do
  subject { described_class.call(order_params) }
  let(:cart) { create(:cart, user: user) }
  let(:user) { create(:user) }
  let(:product) { create(:product, quantity: 10) }
  let(:order_params) { { product_id: product.id, quantity: 5, user_id: user.id, cart_id: cart.id } }

  describe '#call' do
    it 'creates new order' do
      expect { subject }.to change { Order.count }.by(1).and change { product.reload.quantity }.from(10).to(5)
    end
  end
end
