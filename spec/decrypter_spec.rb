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
      decrypt = Decrypter.new

      expect(decrypt.base_set[0]).to eq('a')
      expect(decrypt.spec_chars_set[0]).to eq('!')
      expect(decrypt).to be_instance_of(Decrypter)
    end
  end

  describe '#reverse_shifts' do
    it 'converts the integer elements of full collection of' do
      decrypt        = Decrypter.new
      converted_key  = Key.new('02715').crypt_key
      converted_date = decrypt.process_date(date)
      single_shifts  = decrypt.create_shifts(converted_key, converted_date)
      all_shifts     = decrypt.assemble_shifts_full(message, single_shifts)
      expected       = [-3, -27, -73, -20, -3, -27, -73, -20, -3, -27, -73, -20]

      expect(decrypt.reverse_shifts(all_shifts)).to eq(expected)
    end
  end

  describe '#decrypt' do
    it 'rotates all of the characters in the message shift number of times at corresponding indexes' do
      decrypt           = Decrypter.new
      converted_key     = Key.new('02715').crypt_key
      converted_date    = decrypt.process_date(date)
      single_shifts     = decrypt.create_shifts(converted_key, converted_date)
      all_shifts        = decrypt.assemble_shifts_full(message, single_shifts)
      reverse_shifts    = decrypt.reverse_shifts(all_shifts)
      encrypted_message = decrypt.encrypt_decrypt('hello world', all_shifts).join
      expected          = "hello world"

      expect(decrypt.encrypt_decrypt(encrypted_message, reverse_shifts).join).to eq(expected)
    end
  end
end