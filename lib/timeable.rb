# frozen_string_literal: true

require 'time'

# This is the timeable module
module Timeable
  def randomize_date
    Time.now
  end

  def format_time_to_simple(time)
    return time unless time.is_a?(Time)
    time.strftime('%d%m%y')
  end

  def format_date(date)
    return format_time_to_simple(date) unless date.nil?
    format_time_to_simple(randomize_date).to_i
  end
end
