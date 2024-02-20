# frozen_string_literal: true

module DateParser
  extend ActiveSupport::Concern

  def convert_date(date)
    date.localtime.strftime '%Y-%m-%d %H:%M:%S'
  end
end
