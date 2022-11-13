# frozen_string_literal: true

require_relative '../lib/timeable'
require_relative '../lib/calculable'
require_relative '../lib/crypt'

# Encrypter class
class Encrypter

  attr_reader :base_set,
              :spec_chars_set

  def initialize
    @base_set       = ('a'..'z').to_a << ' '
    @spec_chars_set = ('!'..'?').to_a.concat(['_', '\\', '@'])
  end
end
