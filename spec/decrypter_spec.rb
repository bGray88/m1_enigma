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

  describe '#process_date' do
    it 'converts the date into a four element collection or random collection of four if no passed args' do
      decrypt = Decrypter.new

      expect(decrypt.process_date(date)).to eq([1, 0, 2, 5])

      allow(decrypt).to receive(:process_date).and_return([5, 5, 5, 5])

      expect(decrypt.process_date(nil)).to eq([5, 5, 5, 5])
    end
  end

  describe '#preserve_special_characters' do
    it 'reserves special characters and their placement in the message for restoration later' do
      decrypt = Decrypter.new

      expect(decrypt.preserve_spec_chars(message)).to eq([[11, "!"]])
      expect(decrypt.preserve_spec_chars('')).to eq([])
    end
  end

  describe '#restore_special_characters' do
    it 'restores special characters based on the second character in the nested array' do
      decrypt = Decrypter.new

      expect(decrypt.restore_spec_chars('Hello World'.chars, [[11, "!"]])).to eq('Hello World!')
      expect(decrypt.restore_spec_chars('Hello'.chars, [])).to eq('Hello')
    end
  end

  describe '#process' do
    it 'preforms the act of encryption using assembled keys and shifts' do
      decrypt = Decrypter.new

      expect(decrypt.process(message, key, date)[:decryption]).to eq("hello world!")
      expect(decrypt.process(message, key, date)[:key]).to eq("02715")
      expect(decrypt.process(message, key, date)[:date]).to eq("040895")
    end
  end

  describe '#create_shifts' do
    it 'provides the necessary rotation assignments using key and offsets' do
      decrypt        = Decrypter.new
      converted_key  = Key.new('02715').crypt_key
      random_key     = double('key')
      allow(random_key).to receive(:zip).and_return([[2, 1], [27, 0], [71, 2], [15, 5]])
      converted_date = decrypt.process_date(date)

      expect(decrypt.create_shifts(converted_key, converted_date)).to eq([3, 27, 73, 20])
      expect(decrypt.create_shifts(random_key, converted_date)).to eq([3, 27, 73, 20])
    end
  end

  describe '#assemble_shifts_full' do
    it 'creates an array message length long for all rotation index syncing' do
      decrypt        = Decrypter.new
      converted_key  = Key.new('02715').crypt_key
      converted_date = decrypt.process_date(date)
      full_shifts    = decrypt.create_shifts(converted_key, converted_date)

      expected = [3, 27, 73, 20, 3, 27, 73, 20, 3, 27, 73, 20]

      expect(decrypt.assemble_shifts_full(message, full_shifts)).to eq(expected)
    end
  end

  describe '#encrypt_decrypt' do
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