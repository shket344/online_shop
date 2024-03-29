# frozen_string_literal: true

# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  description :text
#  image_url   :string
#  price       :decimal(8, 2)    not null
#  quantity    :integer          default(0)
#  title       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint
#
# Indexes
#
#  index_products_on_category_id  (category_id)
#  index_products_on_title        (title) UNIQUE
#  index_products_on_user_id      (user_id)
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe '#create' do
    context 'with valid attributes' do
      include_examples 'creates_object_for', :product
    end

    context 'with invalid attributes' do
      context 'with missing category' do
        include_examples 'not_create_object_for', :product, category_id: nil
      end

      context 'with invalid title' do
        context 'when missing title' do
          include_examples 'not_create_object_for', :product, title: nil
        end

        context 'when title present' do
          before { create(:product, title: 'test') }

          include_examples 'not_create_object_for', :product, title: 'test'
        end
      end

      context 'with invalid price' do
        context 'when missing price' do
          include_examples 'not_create_object_for', :product, price: nil
        end

        context 'when zero price' do
          include_examples 'not_create_object_for', :product, price: 0
        end

        context 'when price belong 0.01' do
          include_examples 'not_create_object_for', :product, price: 0.001
        end
      end

      context 'with invalid quantity' do
        context 'when quantity belong 0' do
          include_examples 'not_create_object_for', :product, quantity: -5
        end
      end
    end
  end
end
