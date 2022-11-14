# frozen_string_literal: true

require './lib/stringable'

describe Stringable do
  
  before(:each) do
    class Dummy
      include Stringable
    end
  end

  let(:dummy) { Dummy.new }
  let(:message) { 'Hello World!' }
  let(:key)     { '02715' }
  let(:date)    { '040895' }

  describe '#split_into_pairs' do
    it 'takes string and splits the consecutive characters into pairs' do
      expected = [["0", "2"], ["2", "7"], ["7", "1"], ["1", "5"]]

      expect(dummy.split_into_pairs('02715')).to eq(expected)
    end
  end

  describe '#nest_pairs' do
    it 'combines pairs that have been split into a single levelled array of integers' do
      pairs    = [["0", "2"], ["2", "7"], ["7", "1"], ["1", "5"]]
      expected = [2, 27, 71, 15]

      expect(dummy.nest_pairs(pairs)).to eq(expected)
    end
  end

  describe '#strip_string' do
    it 'removes characters passed in array from a string' do
      encrypt    = Encrypt.new
      spec_chars = ["!"]

      expect(encrypt.strip_string(message, spec_chars)).to eq('Hello World')
      expect(encrypt.strip_string('', [])).to eq('')
    end
  end
end
