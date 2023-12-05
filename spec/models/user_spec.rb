# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  name                   :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  surname                :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
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
    end
  end
end
