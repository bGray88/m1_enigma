# frozen_string_literal: true

require 'rspec'
require_relative '../lib/enigma'

describe Enigma do
  it 'exists' do
    enigma = Enigma.new

    expect(enigma).to be_instance_of(Enigma)
  end
end
