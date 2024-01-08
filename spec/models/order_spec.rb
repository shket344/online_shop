# frozen_string_literal: true

# == Schema Information
#
# Table name: orders
#
#  id         :bigint           not null, primary key
#  quantity   :integer          default(0)
#  status     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_orders_on_product_id  (product_id)
#  index_orders_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#create' do
    context 'with valid params' do
      include_examples 'creates_object_for', :order
    end

    context 'with invalid params' do
      context 'with invalid user' do
        context 'when no user' do
          include_examples 'not_create_object_for', :order, user: nil
        end
      end

      context 'with invalid product' do
        context 'when no product' do
          include_examples 'not_create_object_for', :order, product: nil
        end
      end

      context 'with invalid quantity' do
        context 'when quantity belong 0' do
          include_examples 'not_create_object_for', :order, quantity: -5
        end
      end
    end
  end

  describe '#total' do
    let(:product) { create(:product, price: 0.1) }
    let(:order) { create(:order, quantity: 5, product: product) }

    it 'returns total price for product' do
      expect(order.total).to eq 0.5
    end
  end
end
