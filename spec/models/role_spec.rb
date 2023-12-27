# frozen_string_literal: true

# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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

      context 'when title present' do
        before { create(:role, title: 'user') }

        include_examples 'not_create_object_for', :role, title: 'user'
      end
    end
  end
end
