# frozen_string_literal: true

# Key class
class Key

  attr_reader :key

  def initialize(key)
    @key = key
  end

  def random_key
    rand(0...100000).to_s.rjust(5, '0')
  end
end
