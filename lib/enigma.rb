# frozen_string_literal: true

require_relative '../lib/encrypter'
require_relative '../lib/decrypter'

# Enigma class
class Enigma
  def initialize
    @encrypter = Encrypter.new
    @decrypter = Decrypter.new
  end

  def encrypt(message, key = nil, date = nil)
    @encrypter.process(message, key, date)
  end

  def decrypt(message, key = nil, date = nil)
    @decrypter.process(message, key, date)
  end
end
