require_relative '../lib/enigma'

read_file = "#{ARGV[0]}".delete('/lib')
write_file = "#{ARGV[1]}".delete('/lib')

if File.exist?(read_file)
  enigma = Enigma.new
  args = []
  File.foreach(read_file) { |line| args = line } 
  decrypted = enigma.decrypt(*args, ARGV[2], ARGV[3])
  File.open(write_file, "w") do |file|
    file.write(
      "#{decrypted[:decryption]}"
    )
  end
  puts "Created \'#{write_file}\' with the key #{decrypted[:key]} and date #{decrypted[:date]}"
else
  puts "Can't find that file, love."
end
