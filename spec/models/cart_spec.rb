# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Cart, type: :model do
  RSpec::Matchers.define_negated_matcher :not_change, :change

  describe '#create' do
    context 'with valid params' do
      include_examples 'creates_object_for', :cart
    end

    context 'with invalid params' do
      context 'with invalid user' do
        context 'when no user' do
          include_examples 'not_create_object_for', :cart, user: nil
        end
      end
    end
  end

  describe 'state transitions' do
    let(:cart) { create(:cart) }

    context 'when order create' do
      it 'moves from created to processing' do
        expect(cart).to transition_from(:created).to(:processing).on_event(:book)
      end
    end

    context 'when order approved' do
      it 'moves from processing to approved' do
        expect(cart).to transition_from(:processing).to(:approved).on_event(:approve)
      end
    end

    context 'when order declined' do
      it 'moves from processing to declined' do
        expect(cart).to transition_from(:processing).to(:declined).on_event(:decline)
      end
    end
  end

  describe '#total_price' do
    let(:cart) { create(:cart, :filled) }

    it 'returns total price for all orders' do
      expect(cart.total_price).to eq 0.15
    end
  end

  describe '#make_order' do
    subject { cart.make_order }
    let(:cart) { create(:cart) }

    context 'with valid data' do
      let(:order) { create(:order, user: cart.user, cart: cart) }

      it 'changes status to processing for cart and order' do
        expect { subject }.to change { cart.state }.from('created')
                                                   .to('processing').and change {
                                                                           order.reload.status
                                                                         }.from('created').to('processing')
      end
    end

    context 'with invalid data' do
      let(:order) { create(:order, user: cart.user, cart: cart, status: 'processing') }

      it 'does not change status for cart and order' do
        expect { subject }.to not_change { cart.state }.and(not_change { order.reload.status })
                          .and raise_error AASM::InvalidTransition
      end
    end
  end

  describe '#approve_order' do
    subject { cart.approve_order }
    let(:cart) { create(:cart, state: 'processing') }

    context 'with valid data' do
      let(:order) { create(:order, user: cart.user, cart: cart, status: 'processing') }

      it 'changes status to aproved for cart and order' do
        expect { subject }.to change { cart.state }.from('processing')
                                                   .to('approved').and change {
                                                                         order.reload.status
                                                                       }.from('processing').to('approved')
      end
    end

    context 'with invalid data' do
      let(:order) { create(:order, user: cart.user, cart: cart, status: 'created') }

      it 'does not change status for cart and order' do
        expect { subject }.to not_change { cart.state }.and(not_change { order.reload.status })
                          .and raise_error AASM::InvalidTransition
      end
    end
  end

  describe '#decline_order' do
    subject { cart.decline_order }

    let(:cart) { create(:cart, state: 'processing') }

    context 'with valid data' do
      let(:order) { create(:order, user: cart.user, cart: cart, status: 'processing') }

      it 'changes status to aproved for cart and order' do
        expect { subject }.to change { cart.state }.from('processing')
                                                   .to('declined').and change {
                                                                         order.reload.status
                                                                       }.from('processing').to('declined')
      end
    end

    context 'with invalid data' do
      let(:order) { create(:order, user: cart.user, cart: cart, status: 'created') }

      it 'does not change status for cart and order' do
        expect { subject }.to not_change { cart.state }.and(not_change { order.reload.status })
                          .and raise_error AASM::InvalidTransition
      end
    end
  end

  describe '#retry_order' do
    subject { cart.retry_order }

    let(:cart) { create(:cart, state: 'declined') }

    context 'with valid data' do
      let(:order) { create(:order, user: cart.user, cart: cart, status: 'declined') }

      it 'changes status to aproved for cart and order' do
        expect { subject }.to change { cart.state }.from('declined')
                                                   .to('processing').and change {
                                                                           order.reload.status
                                                                         }.from('declined').to('processing')
      end
    end

    context 'with invalid data' do
      let(:order) { create(:order, user: cart.user, cart: cart, status: 'created') }

      it 'does not change status for cart and order' do
        expect { subject }.to not_change { cart.state }.and(not_change { order.reload.status })
                          .and raise_error AASM::InvalidTransition
      end
    end
  end

  describe '#repeat_order' do
    subject { cart.repeat_order }

    let(:cart) { create(:cart, state: 'approved') }

    context 'with valid data' do
      let(:order) { create(:order, user: cart.user, cart: cart, status: 'approved') }

      it 'changes status to aproved for cart and order' do
        expect { subject }.to change { cart.state }.from('approved')
                                                   .to('processing').and change {
                                                                           order.reload.status
                                                                         }.from('approved').to('processing')
      end
    end

    context 'with invalid data' do
      let(:order) { create(:order, user: cart.user, cart: cart, status: 'created') }

      it 'does not change status for cart and order' do
        expect { subject }.to not_change { cart.state }.and(not_change { order.reload.status })
                          .and raise_error AASM::InvalidTransition
      end
    end
  end
end
