# frozen_string_literal: true

require 'rspec'
require_relative '../lib/key'

describe Key do
  it 'exists' do
    key = Key.new([1, 0, 2, 5])

    expect(key).to be_instance_of(Key)
    expect(key.key).to be_instance_of(Key)
  end
end
