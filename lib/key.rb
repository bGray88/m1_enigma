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

  def process_key
    @key ||= random_key
    pairs = @key.chars.each_cons(2).to_a
    pairs.map { |pair| pair.join.to_i }
  end
end
