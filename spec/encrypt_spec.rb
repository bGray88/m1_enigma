# frozen_string_literal: true

require 'rspec'
require_relative '../lib/encrypt'

describe Key do
  describe '#initialize' do
    it 'exists' do
      encrypt = Encrypt.new

      expect(encrypt).to be_instance_of(Encrypt)
    end
  end
end
