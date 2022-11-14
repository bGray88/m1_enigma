require 'benchmark'
require_relative './lib/enigma'

time = Benchmark.measure {
  Dir.chdir('../enigma'){
    system('rspec ./spec/spec_helper.rb')
  }
}
puts time.real

enigma = Enigma.new
p encrypted = enigma.encrypt("hello world!?", "02715", "40895")
# p decrypted = enigma.decrypt(encrypted[:encryption], encrypted[:key], encrypted[:date])
