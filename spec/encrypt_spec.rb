# frozen_string_literal: true

require 'rspec'
require_relative '../lib/encrypt'

describe Encrypt do
  describe '#initialize' do
    it 'exists and has attributes' do
      encrypt = Encrypt.new

      expect(encrypt.base_set[0]).to eq('a')
      expect(encrypt.spec_chars_set[0]).to eq('!')
      expect(encrypt).to be_instance_of(Encrypt)
    end
  end
end
