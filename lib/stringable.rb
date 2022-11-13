# frozen_string_literal: true

# This is the stringable module
module Stringable
  def split_into_pairs(chars)
    chars.chars.each_cons(2).to_a
  end
end
