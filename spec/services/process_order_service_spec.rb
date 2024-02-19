# frozen_string_literal: true

require 'rails_helper'

describe ProcessOrderService do
  subject { described_class.call(cart) }
  let!(:cart) { create(:cart, user: user, state: :processing) }
  let!(:user) { create(:user, fund: fund) }
  let(:product) { create(:product, quantity: 1, price: 1) }
  let!(:owner) { create(:user, :owner, fund: 50) }
  let!(:order) { create(:order, user: user, cart: cart, product: product, status: :processing, quantity: 1) }

  describe '#call' do
    context 'when funds enough for order' do
      let(:fund) { 20 }

      it 'approve order' do
        expect { subject }.to change { user.reload.fund }.from(20).to(19)
                                                         .and change { owner.reload.fund }.from(50).to(51)
                                                                                          .and change {
                                                                                                 cart.state
                                                                                               }.from('processing').to('approved')
      end
    end

    context 'when funds is not enough for order' do
      let(:fund) { 0.5 }

      it 'decline order' do
        expect { subject }.to change { cart.state }.from('processing').to('declined')
                                                   .and change { order.reload.status }.from('processing').to('declined')
                                                                                      .and not_change {
                                                                                             user.reload.fund
                                                                                           }
          .and(not_change { owner.reload.fund })
          .and change { product.reload.quantity }.from(1).to(2)
      end
    end
  end
end
