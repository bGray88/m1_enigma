# frozen_string_literal: true

require_relative '../lib/encrypt'

# Enigma class
class Enigma
  def initialize
    @encrypt = Encrypt.new
  end

  def encrypt(message, key = nil, date = nil)
    @encrypt.process(message, key, date)
  end
end
