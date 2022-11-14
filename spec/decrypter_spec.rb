# frozen_string_literal: true

require 'rspec'
require_relative '../lib/decrypter'
require_relative '../lib/key'

describe Decrypter do
  let(:message) { "keder ohulw!" }
  let(:key)     { '02715' }
  let(:date)    { '040895' }

  describe '#initialize' do
    it 'exists and has attributes' do
      encrypt = Decrypter.new

      expect(encrypt.base_set[0]).to eq('a')
      expect(encrypt.spec_chars_set[0]).to eq('!')
      expect(encrypt).to be_instance_of(Decrypter)
    end
  end
end