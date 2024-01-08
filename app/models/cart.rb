# frozen_string_literal: true

# == Schema Information
#
# Table name: carts
#
#  id         :bigint           not null, primary key
#  state      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Cart < ApplicationRecord
  include AASM

  has_many :orders
  belongs_to :user

  aasm column: :state do
    state :created, initial: true
    state :processing, :approved, :declined

    event :book do
      transitions from: :created, to: :processing
    end

    event :approve do
      transitions from: :processing, to: :approved
    end

    event :decline do
      transitions from: :processing, to: :declined
    end
  end
end
