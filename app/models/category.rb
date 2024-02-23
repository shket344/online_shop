# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#

class Category < ApplicationRecord
  paginates_per 20

  has_many :products
  belongs_to :user

  validates_presence_of :title
  validates :title, uniqueness: true
end
