# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe '#index' do
    it 'renders index template' do
      get :index

      expect(response).to render_template('index')
    end
  end
end
