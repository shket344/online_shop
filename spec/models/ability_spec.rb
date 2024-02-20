# frozen_string_literal: true

require 'cancan/matchers'
require 'rails_helper'

describe 'User' do
  describe 'abilities' do
    subject(:ability) { Ability.new(user) }

    context 'when there is no user' do
      let(:user) { nil }

      it { is_expected.to be_able_to(:read, Category) }
    end

    context 'when is owner' do
      let(:user) { create(:user, :owner) }

      it { is_expected.to be_able_to(:manage, :all) }
      it { is_expected.to be_able_to(:manage, ActiveAdmin::Page, name: 'Dashboard', namespace_name: 'admin') }
    end

    context 'when is admin' do
      let(:user) { create(:user, :admin) }

      it { is_expected.to be_able_to(:manage, :all) }
      it { is_expected.to be_able_to(:read, :all) }
    end

    context 'when is user' do
      let(:user) { create(:user, :simple_user) }

      it { is_expected.to be_able_to(:read, :all) }
      it { is_expected.to be_able_to(:manage, User) }
    end
  end
end
