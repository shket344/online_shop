# frozen_string_literal: true

class UsersController < Devise::RegistrationsController
  load_and_authorize_resource

  before_action :find_user, only: %i[show add_funds destroy]

  def show; end

  def add_funds
    balance = @user.fund + params[:fund].to_f
    @user.update!(fund: balance)
    redirect_to user_path(@user)
  end

  def destroy
    @user.destroy
    redirect_to :root
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
