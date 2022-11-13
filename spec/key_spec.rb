# frozen_string_literal: true

require 'rspec'
require_relative '../lib/key'

describe Key do
  describe '#initialize' do
    it 'exists' do
      key = Key.new([1, 0, 2, 5])

      expect(key).to be_instance_of(Key)
      expect(key.key).to eq([1, 0, 2, 5])
    end
  end

  describe '#random_key' do
    it 'provides a random key in the event when a key is not provided' do
      key1 = Key.new()
      allow(key1).to receive(:random_key).and_return([1, 0, 2, 5])

      expect(key1.random_key).to eq([1, 0, 2, 5])
    end
  end
end
