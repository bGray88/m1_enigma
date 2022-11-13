# frozen_string_literal: true

# Encrypt class
class Encrypt

  attr_reader :base_set,
              :spec_chars_set

  def initialize
    @base_set       = ('a'..'z').to_a << ' '
    @spec_chars_set = ('!'..'?').to_a.concat(['_', '\\', '@'])
  end

  def process(message, key = nil, date = nil)
    spec_chars = preserve_special_characters(message)
  end

  def process_date(date)
    date = Time.now.strftime('%d%m%y') if date.nil?
    offset = date.to_i ** 2
    offset.to_s[-4..-1].to_i.digits.reverse
  end
end
