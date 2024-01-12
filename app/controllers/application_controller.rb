# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :initialize_cart

  private

  def initialize_cart
    return unless current_user

    @cart ||= Cart.preload(:orders).includes(orders: :product).find_by(id: session[:cart_id])

    return if @cart

    @cart = Cart.create(user: current_user)
    session[:cart_id] = @cart.id
  end

  protected

  def access_denied(exception)
    redirect_to root_path, alert: exception.message
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name surname])
  end
end
