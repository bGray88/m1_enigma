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
p decrypted = enigma.decrypt(encrypted[:encryption], encrypted[:key], encrypted[:date])
p encrypted = enigma.encrypt("Super_Fan", "52648")
p decrypted = enigma.decrypt(encrypted[:encryption], encrypted[:key], encrypted[:date])
p encrypted = enigma.encrypt("Je$us Fr3Ak!", "33333")
p decrypted = enigma.decrypt(encrypted[:encryption], encrypted[:key], encrypted[:date])
p encrypted = enigma.encrypt("cr3@M\'dC0rN")
p decrypted = enigma.decrypt(encrypted[:encryption], encrypted[:key])
