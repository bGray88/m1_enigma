require_relative '../lib/enigma'

read_file = "#{ARGV[0]}".delete('/lib')
write_file = "#{ARGV[1]}".delete('/lib')

if File.exist?(read_file)
  enigma = Enigma.new
  args = []

  File.foreach(read_file) { |line| args = line }

  args = [args, ARGV[2], ARGV[3]]

  if ARGV[2] =~ /\d$/ && !ARGV[3] =~ /\d$/
    arg2 = ARGV[2]
    args = args.gsub(arg2, '').strip
    args = [args, arg2]
  end

  decrypted = enigma.decrypt(*args)

  File.open(write_file, "w") { |file| file.write("#{decrypted[:decryption]}") }
  puts "Created \'#{write_file}\' with the key #{decrypted[:key]} and date #{decrypted[:date]}"
else
  puts "Can't find that file, love."
end
