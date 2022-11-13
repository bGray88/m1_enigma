# frozen_string_literal: true

require 'rspec'
require_relative '../lib/key'

describe Key do
  it 'exists' do
    key = Key.new

    expect(key).to be_instance_of(Key)
  end
end
