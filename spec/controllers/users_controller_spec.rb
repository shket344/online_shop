# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    login_user
    let(:cur_user) { subject.current_user }

    it 'assigns user' do
      get :show, params: { id: cur_user.id }
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE #destroy' do
    login_user
    let(:cur_user) { subject.current_user }

    it 'delete user' do
      delete :destroy, params: { id: cur_user.id }
      expect(response).to redirect_to('/')
    end
  end
end
