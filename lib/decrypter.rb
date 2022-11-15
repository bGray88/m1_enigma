# frozen_string_literal: true

require_relative '../lib/key'
require_relative '../lib/timeable'
require_relative '../lib/crypt'

# Decrypter class
class Decrypter < Crypt
  def process(message, key, date = nil)
    crypt_data = super
    shifts_reversed   = reverse_shifts(assemble_shifts_full(crypt_data[:converted_message], crypt_data[:shifts]))
    decrypted_message = encrypt_decrypt(crypt_data[:converted_message], shifts_reversed)
    { decryption: restore_spec_chars(decrypted_message, crypt_data[:spec_chars]),
      key: crypt_data[:converted_key].key, date: format_date(date).to_s }
  end

  def reverse_shifts(shifts)
    shifts.map { |shift| -shift }
  end
end
