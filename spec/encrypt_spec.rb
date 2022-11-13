# frozen_string_literal: true

require 'rspec'
require_relative '../lib/encrypt'

describe Encrypt do
  let(:message) { 'Hello World!' }
  let(:key)     { '02715' }
  let(:date)    { '04895' }

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

      expect(encrypt.process_date(date)).to eq([1, 0, 2, 5])

      allow(encrypt).to receive(:process_date).and_return([5, 5, 5, 5])

      expect(encrypt.process_date(nil)).to eq([5, 5, 5, 5])
    end
  end

  describe '#preserve_special_characters' do
    it 'reserves special characters and their placement in the message for restoration later' do
      encrypt = Encrypt.new

      expect(encrypt.preserve_spec_chars(message)).to eq([[11, "!"]])
      expect(encrypt.preserve_spec_chars('')).to eq([])
    end
  end

  describe '#restore_special_characters' do
    it 'restores special characters based on the second character in the nested array' do
      encrypt = Encrypt.new

      expect(encrypt.restore_spec_chars('Hello World'.chars, [[11, "!"]])).to eq(message)
      expect(encrypt.restore_spec_chars('Hello'.chars, [])).to eq('Hello')
    end
  end

  describe '#strip_message' do
    it 'removes special_characters passed in args from a string' do
      encrypt = Encrypt.new
      spec_chars = encrypt.preserve_spec_chars(message)

      expect(encrypt.preserve_spec_chars(message)).to eq([[11, "!"]])
      expect(encrypt.strip_message(message, spec_chars)).to eq('Hello World')
      expect(encrypt.strip_message('', [])).to eq('')
    end
  end

  describe '#process' do
    it 'preforms the act of encryption using assembled keys and shifts' do
      encrypt = Encrypt.new
      expected = [[[11, "!"]], "hello world!", Key.new(key), [1, 0, 2, 5]]

      expect(encrypt.process(message, key, date)[0]).to eq(expected[0])
      expect(encrypt.process(message, key, date)[1]).to eq(expected[1])
      expect(encrypt.process(message, key, date)[2].key).to eq(expected[2].key)
      expect(encrypt.process(message, key, date)[3]).to eq(expected[3])
    end
  end
end
