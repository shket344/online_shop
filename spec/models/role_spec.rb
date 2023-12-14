# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Role, type: :model do
  describe '#create' do
    context 'with valid params' do
      include_examples 'creates_object_for', :role
    end

    context 'with invalid params' do
      context 'when missing title' do
        include_examples 'not_create_object_for', :role, title: nil
      end
    end
  end
end
