# frozen_string_literal: true

require 'rspec'
require_relative '../lib/enigma'

describe Enigma do
  let(:message) { 'Hello World!' }
  let(:key)     { '02715' }
  let(:date)    { '040895' }

  describe '#initialize' do
    it 'exists and has attributes' do
      enigma = Enigma.new

      expect(enigma).to be_instance_of(Enigma)
    end
  end

  describe '#encrypt' do
    it 'calls the encrypt process method to initiate the encryption' do
      enigma = Enigma.new
      encrypted = enigma.encrypt(message, key, date)

      expect(encrypted[1]).to eq(message.downcase)
      expect(encrypted[2].key).to eq(key)
      expect(encrypted[3]).to eq([1, 0, 2, 5])
    end
  end
end
