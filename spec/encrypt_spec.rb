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

  describe '#process_date' do
    it 'converts the date into a four element collection or random collection of four if no passed args' do
      encrypt = Encrypt.new

      expect(encrypt.process_date('04895')).to eq([1, 0, 2, 5])

      allow(encrypt).to receive(:process_date).and_return([5, 5, 5, 5])

      expect(encrypt.process_date(nil)).to eq([5, 5, 5, 5])
    end
  end

  describe '#preserve_special_characters' do
    it 'reserves special characters and their placement in the message for restoration later' do
      encrypt = Encrypt.new

      expect(encrypt.preserve_special_characters('Hello!')).to eq([[5, "!"]])
      expect(encrypt.preserve_special_characters('')).to eq([])
    end
  end
end
