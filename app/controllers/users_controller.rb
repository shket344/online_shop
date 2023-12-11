# frozen_string_literal: true

class UsersController < Devise::RegistrationsController
  before_action :find_user, only: %i[show destroy]

  def show; end

  def destroy
    @user.destroy
    redirect_to :root
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
