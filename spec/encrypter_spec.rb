# frozen_string_literal: true

require 'rspec'
require_relative '../lib/encrypter'
require_relative '../lib/key'

describe Encrypter do
  let(:message) { 'Hello World!' }
  let(:key)     { '02715' }
  let(:date)    { '040895' }

  describe '#initialize' do
    it 'exists and has attributes' do
      encrypt = Encrypter.new

      expect(encrypt.base_set[0]).to eq('a')
      expect(encrypt.spec_chars_set[0]).to eq('!')
      expect(encrypt).to be_instance_of(Encrypter)
    end
  end

  describe '#process_date' do
    it 'converts the date into a four element collection or random collection of four if no passed args' do
      encrypt = Encrypter.new

      expect(encrypt.process_date(date)).to eq([1, 0, 2, 5])

      allow(encrypt).to receive(:process_date).and_return([5, 5, 5, 5])

      expect(encrypt.process_date(nil)).to eq([5, 5, 5, 5])
    end
  end

  describe '#preserve_special_characters' do
    it 'reserves special characters and their placement in the message for restoration later' do
      encrypt = Encrypter.new

      expect(encrypt.preserve_spec_chars(message)).to eq([[11, "!"]])
      expect(encrypt.preserve_spec_chars('')).to eq([])
    end
  end

  describe '#restore_special_characters' do
    it 'restores special characters based on the second character in the nested array' do
      encrypt = Encrypter.new

      expect(encrypt.restore_spec_chars('Hello World'.chars, [[11, "!"]])).to eq(message)
      expect(encrypt.restore_spec_chars('Hello'.chars, [])).to eq('Hello')
    end
  end

  describe '#process' do
    it 'preforms the act of encryption using assembled keys and shifts' do
      encrypt = Encrypter.new

      expect(encrypt.process(message, key, date)[:encryption]).to eq("keder ohulw!")
      expect(encrypt.process(message, key, date)[:key]).to eq("02715")
      expect(encrypt.process(message, key, date)[:date]).to eq("040895")
    end
  end

  describe '#create_shifts' do
    it 'provides the necessary rotation assignments using key and offsets' do
      encrypt        = Encrypter.new
      converted_key  = Key.new('02715').process_key
      random_key     = double('key')
      allow(random_key).to receive(:zip).and_return([[2, 1], [27, 0], [71, 2], [15, 5]])
      converted_date = encrypt.process_date(date)

      expect(encrypt.create_shifts(converted_key, converted_date)).to eq([3, 27, 73, 20])
      expect(encrypt.create_shifts(random_key, converted_date)).to eq([3, 27, 73, 20])
    end
  end

  describe '#assemble_shifts_full' do
    it 'creates an array message length long for all rotation index syncing' do
      encrypt        = Encrypter.new
      converted_key  = Key.new('02715').process_key
      converted_date = encrypt.process_date(date)
      full_shifts    = encrypt.create_shifts(converted_key, converted_date)

      expected = [3, 27, 73, 20, 3, 27, 73, 20, 3, 27, 73, 20]

      expect(encrypt.assemble_shifts_full(message, full_shifts)).to eq(expected)
    end
  end

  describe '#encrypt_decrypt' do
    it 'rotates all of the characters in the message shift number of times at corresponding indexes' do
      encrypt        = Encrypter.new
      converted_key  = Key.new('02715').process_key
      converted_date = encrypt.process_date(date)
      single_shifts  = encrypt.create_shifts(converted_key, converted_date)
      all_shifts     = encrypt.assemble_shifts_full(message, single_shifts)
      expected       = "keder ohulw"

      expect(encrypt.encrypt('hello world', all_shifts).join).to eq(expected)
    end
  end

  describe '#reverse_shifts' do
    it 'converts the integer elements of full collection of' do
      encrypt        = Encrypter.new
      converted_key  = Key.new('02715').process_key
      converted_date = encrypt.process_date(date)
      single_shifts  = encrypt.create_shifts(converted_key, converted_date)
      all_shifts     = encrypt.assemble_shifts_full(message, single_shifts)
      expected       = [-3, -27, -73, -20, -3, -27, -73, -20, -3, -27, -73, -20]

      expect(encrypt.reverse_shifts(all_shifts)).to eq(expected)
    end
  end

  describe '#decrypt' do
    it 'rotates all of the characters in the message shift number of times at corresponding indexes' do
      encrypt           = Encrypter.new
      converted_key     = Key.new('02715').process_key
      converted_date    = encrypt.process_date(date)
      single_shifts     = encrypt.create_shifts(converted_key, converted_date)
      all_shifts        = encrypt.assemble_shifts_full(message, single_shifts)
      encrypted_message = encrypt.encrypt_decrypt('hello world', all_shifts).join
      expected          = "hello world"

      expect(encrypt.decrypt(encrypted_message, all_shifts).join).to eq(expected)
    end
  end
end
