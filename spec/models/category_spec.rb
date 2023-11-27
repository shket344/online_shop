# frozen_string_literal: true

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
    end
  end
end
