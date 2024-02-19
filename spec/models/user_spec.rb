# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fund                   :decimal(8, 2)    default(0.0)
#  name                   :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  surname                :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    context 'with valid params' do
      include_examples 'creates_object_for', :user
    end

    context 'with invalid params' do
      context 'when name missing' do
        include_examples 'not_create_object_for', :user, name: nil
      end

      context 'when surname missing' do
        include_examples 'not_create_object_for', :user, surname: nil
      end

      context 'when email missing' do
        include_examples 'not_create_object_for', :user, email: nil
      end

      context 'when password missing' do
        include_examples 'not_create_object_for', :user, password: nil
      end

      context 'when password invalid' do
        include_examples 'not_create_object_for', :user, password: '11'
      end

      context 'when email invalid' do
        include_examples 'not_create_object_for', :user, email: 'test'
      end

      context 'when role empty' do
        include_examples 'not_create_object_for', :user, role: nil
      end
    end
  end

  describe '#full_name' do
    let(:user) { create(:user, name: 'Name', surname: 'Surname') }

    it 'returns full name of the user' do
      expect(user.full_name).to eq 'Name Surname'
    end
  end

  describe '#simple_user?' do
    let(:user) { create(:user, :simple_user) }

    it 'returns role title of the user' do
      expect(user.simple_user?).to be_truthy
    end
  end
end
