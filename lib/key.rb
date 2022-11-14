# frozen_string_literal: true

require_relative '../lib/stringable'

# Key class
class Key
  include Stringable

  attr_reader :key,
              :crypt_key

  def initialize(key)
    @key = key
    @crypt_key = process_key
  end

  private

  def random_key
    rand(0...100000).to_s.rjust(5, '0')
  end

  def process_key
    @key ||= random_key
    nest_pairs(split_into_pairs(@key))
  end
end
