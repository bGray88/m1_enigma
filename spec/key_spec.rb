# frozen_string_literal: true

require 'rspec'
require_relative '../lib/key'

describe Key do
  describe '#initialize' do
    it 'exists' do
      key1 = Key.new('02715')
      key2 = Key.new(nil)

      allow(key2).to receive(:key).and_return('02715')

      expect(key1).to be_instance_of(Key)
      expect(key1.key).to eq('02715')
      expect(key1.crypt_key).to eq([2, 27, 71, 15])
      expect(key2.key).to eq('02715')
    end
  end
end
