# frozen_string_literal: true

require 'rspec'
require_relative '../lib/key'

describe Key do
  describe '#initialize' do
    it 'exists' do
      key = Key.new('02715')

      expect(key).to be_instance_of(Key)
      expect(key.key).to eq('02715')
    end
  end
end
