# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#create' do
    context 'with valid params' do
      include_examples 'creates_object_for', :category
    end

    context 'with invalid params' do
      context 'with invalid title' do
        context 'when title missing' do
          include_examples 'not_create_object_for', :category, title: nil
        end

        context 'when title present' do
          before { create(:category, title: 'test') }

          include_examples 'not_create_object_for', :category, title: 'test'
        end
      end

      context 'with invalid user' do
        context 'when no user' do
          include_examples 'not_create_object_for', :category, user: nil
        end
      end
    end
  end
end
