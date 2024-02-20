# frozen_string_literal: true

class ProcessOrderWorker
  include Sidekiq::Worker

  def perform(cart_id)
    cart = Cart.preload(:orders).includes(:user).find_by(id: cart_id)
    ProcessOrderService.call(cart)
  end
end
