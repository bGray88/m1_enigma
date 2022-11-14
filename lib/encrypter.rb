# frozen_string_literal: true

require_relative '../lib/key'
require_relative '../lib/timeable'
require_relative '../lib/crypt'

# Encrypter class
class Encrypter < Crypt
  def process(message, key = nil, date = nil)
    crypt_data = super
    shifts_update     = assemble_shifts_full(crypt_data[:converted_message], crypt_data[:shifts])
    encrypted_message = encrypt_decrypt(crypt_data[:converted_message], shifts_update)
    { encryption: restore_spec_chars(encrypted_message, crypt_data[:spec_chars]),
      key: crypt_data[:converted_key].key, date: format_date(date).to_s }
  end
end
