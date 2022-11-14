# frozen_string_literal: true

require_relative '../lib/encrypter'

# Enigma class
class Enigma
  def initialize
    @encrypter = Encrypter.new
  end

  def encrypt(message, key = nil, date = nil)
    @encrypter.process(message, key, date)
  end
end
