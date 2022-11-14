# frozen_string_literal: true

require_relative '../lib/key'
require_relative '../lib/timeable'

# Encrypt class
class Encrypt
  include Timeable, Stringable

  attr_reader :base_set,
              :spec_chars_set

  def initialize
    @base_set       = ('a'..'z').to_a << ' '
    @spec_chars_set = ('!'..'?').to_a.concat(['_', '\\', '@'])
  end

  def process(message, key = nil, date = nil)
    spec_chars        = preserve_spec_chars(message.downcase)
    converted_message = strip_string(message.downcase, @spec_chars_set)
    converted_key     = Key.new(key)
    converted_date    = process_date(date)
    shifts_init       = create_shifts(converted_key.process_key, converted_date)
    shifts_update     = assemble_shifts_full(converted_message, shifts_init)
    encrypted_message = encrypt_decrypt(converted_message, shifts_update)
    { encryption: restore_spec_chars(encrypted_message, spec_chars), key: converted_key.key, date: format_date(date).to_s }
  end

  def encrypt_decrypt(message, shifts)
    message.chars.map.with_index do |char, index|
      char_index = @base_set.index(char)
      @base_set.rotate(char_index + shifts[index]).first
    end
  end

  def encrypt(message, shifts)
    encrypt_decrypt(message, shifts)
  end

  def decrypt(message, shifts)
    reversed_shifts = reverse_shifts(shifts)
    encrypt_decrypt(message, reversed_shifts)
  end

  def reverse_shifts(shifts)
    shifts.map { |shift| -shift }
  end

  def process_date(date)
    date = format_date(date)
    offset = date.to_i ** 2
    offset.to_s[-4..-1].to_i.digits.reverse
  end

  def preserve_spec_chars(message)
    message.chars.filter_map.with_index do |char, index|
      [index, char] if @spec_chars_set.include?(char)
    end
  end

  def restore_spec_chars(message, chars)
    chars.each { |char| message.insert(char[0], char[1]) }
    message.join
  end

  def create_shifts(keys, offsets)
    keys.zip(offsets).map { |set| set.sum }
  end

  def assemble_shifts_full(message, shifts)
    (0..message.length).each_with_object([]) do |num, array|
      array.concat(shifts) if (num % 4).zero?
    end[0...message.length]
  end
end
