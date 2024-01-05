# frozen_string_literal: true

require 'rails_helper'
require_relative '../../support/devise'

RSpec.describe Admin::DashboardController, type: :controller do
  let(:current_user) { subject.current_user }

  login_user

  before do
    allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil }
  end

  describe 'GET #index' do
    it 'tries to access admin panel when not owner' do
      get :index
      expect(response).to redirect_to('/')
    end
  end
end
