require 'benchmark'
require_relative './lib/enigma'

time = Benchmark.measure {
  Dir.chdir('../enigma'){
    system('rspec ./spec/spec_helper.rb')
  }
}
puts time.real
