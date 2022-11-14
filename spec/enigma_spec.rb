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

      expect(encrypted[:encryption]).to eq('keder ohulw!')
      expect(encrypted[:key]).to eq(key)
      expect(encrypted[:date]).to eq('040895')
    end
  end
end
