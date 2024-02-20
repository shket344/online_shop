# frozen_string_literal: true

require 'rails_helper'
require 'sidekiq/testing'

describe RetryOrderService do
  subject { described_class.call(cart) }
  let!(:cart) { create(:cart, state: :processing) }
  let!(:product) { create(:product, quantity: 10) }
  let!(:order) { create(:order, cart: cart, product: product, status: :processing, quantity: quantity) }

  describe '#call' do
    context 'when product available for order' do
      let(:quantity) { 5 }

      it 'updates product quantity and performs ProcessOrderWorker' do
        Sidekiq::Testing.fake!
        expect { subject }.to change { product.reload.quantity }.from(10).to(5).and change {
                                                                                      ProcessOrderWorker.jobs.size
                                                                                    }.by(1)
      end
    end

    context 'when product not available for order' do
      let(:quantity) { 12 }

      it 'declines order' do
        expect { subject }.to change { cart.state }.from('processing')
                                                   .to('declined').and change {
                                                                         order.reload.status
                                                                       }.from('processing').to('declined')
      end
    end
  end
end
