# frozen_string_literal: true

# This is the stringable module
module Stringable
  def split_into_pairs(chars)
    chars.chars.each_cons(2).to_a
  end

  def nest_pairs(pairs)
    pairs.map { |pair| pair.join.to_i }
  end

  def strip_string(message, strip_set)
    message = message.chars
    strip_set.each { |char| message.delete(char[1]) }
    message.join
  end
end
