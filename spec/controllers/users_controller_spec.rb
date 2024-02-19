# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe UsersController, type: :controller do
  let(:current_user) { subject.current_user }

  login_user

  before do
    allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) { nil }
  end

  describe 'GET #show' do
    it 'assigns user' do
      get :show, params: { id: current_user.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #add_funds' do
    let(:fund) { 10 }
    let(:new_balance) { fund + 20 }

    it 'add funds to user' do
      post :add_funds, params: { id: current_user.id, fund: fund }

      expect(current_user.reload.fund).to eq new_balance
      expect(response).to redirect_to user_path
    end
  end

  describe 'DELETE #destroy' do
    it 'delete user' do
      delete :destroy, params: { id: current_user.id }
      expect(response).to redirect_to('/')
    end
  end
end
