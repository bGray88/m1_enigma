# frozen_string_literal: true

require './lib/timeable'
require 'time'

describe Timeable do
  
  before(:each) do
    class Dummy
      include Timeable
    end
  end

  let(:dummy) { Dummy.new }

  describe '#randomize_date' do
    it 'returns a time object corresponding to today\' date' do
      expect(dummy.randomize_date).to be_instance_of(Time)
    end
  end

  describe '#format_time_to_simple' do
    it 'returns a simplified date time string' do
      expect(dummy.format_time_to_simple(Time.parse('August 4, 1995'))).to eq('040895')
    end
  end

  describe '#format_date' do
    it 'returns a simplified date time string and a simplified version of todays date if arg is nil' do
      time = double('time')
      allow(time).to receive(:format_time_to_simple).and_return(131122)
      
      expect(dummy.format_date(Time.parse('August 4, 1995'))).to eq('040895')
      expect(dummy.format_date(nil)).to eq(131122)
    end
  end
end
