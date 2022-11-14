require_relative '../lib/enigma'

read_file = "#{ARGV[0]}".delete('/lib')
write_file = "#{ARGV[1]}".delete('/lib')

if File.exist?(read_file)
  enigma = Enigma.new
  args = []
  File.foreach(read_file) { |line| args = line.split(',').map { |arg| arg.strip } }
  encrypted = enigma.encrypt(*args)
  File.open(write_file, "w") do |file|
    file.write(
      "#{encrypted[:encryption]}"
    )
  end
  puts "Created \'#{write_file}\' with the key #{encrypted[:key]} and date #{encrypted[:date]}"
else
  puts "Can't find that file, love."
end
