# frozen_string_literal: true

class Role < ApplicationRecord
  validates_presence_of :title
end
