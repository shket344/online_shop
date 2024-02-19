# frozen_string_literal: true

require 'rails_helper'

describe UpdateOrderService do
  subject { described_class.call(order, order_params, action) }
  let(:cart) { create(:cart, user: user) }
  let(:user) { create(:user) }
  let(:product) { create(:product, quantity: 10) }
  let(:order) { create(:order, user: user, cart: cart, product: product, quantity: 5) }
  let(:order_params) { { product_id: product.id, quantity: 3 } }

  describe '#call' do
    context 'when update action' do
      let(:action) { 'update' }

      it 'updates order' do
        expect { subject }.to change { order.quantity }.from(5).to(3).and change {
                                                                            product.reload.quantity
                                                                          }.from(10).to(12)
      end
    end

    context 'when add action' do
      let(:action) { 'add' }

      it 'updates order' do
        expect { subject }.to change { order.quantity }.from(5).to(8).and change {
                                                                            product.reload.quantity
                                                                          }.from(10).to(7)
      end
    end

    context 'when destroy action' do
      let(:action) { 'destroy' }

      it 'updates order' do
        subject
        expect(product.reload.quantity).to eq 15
        expect { order.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when unknown action' do
      let(:action) { 'test' }

      it 'raises standard error' do
        expect { subject }.to raise_error StandardError
      end
    end
  end
end
