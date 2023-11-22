# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
  has_many :products

  validates_presence_of :title
  validates :title, uniqueness: true
end
