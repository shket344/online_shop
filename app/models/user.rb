# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  fund                   :decimal(8, 2)    default(0.0)
#  name                   :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  surname                :string           default(""), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :bigint
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role_id               (role_id)
#

class User < ApplicationRecord
  belongs_to :role
  has_many :products, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :carts, dependent: :destroy
  has_many :orders, dependent: :destroy

  validates_presence_of :name, :surname, :email, :role
  before_validation :assign_role

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  def full_name
    "#{name} #{surname}"
  end

  def simple_user?
    role.title == 'user'
  end

  private

  def assign_role
    return unless role.nil?

    self.role = Role.find_by(title: 'user')
  end
end
