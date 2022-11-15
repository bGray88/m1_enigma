require_relative '../lib/enigma'

read_file = "#{ARGV[0]}".gsub('/lib', '')
write_file = "#{ARGV[1]}".gsub('/lib', '')

if File.exist?(read_file)
  enigma = Enigma.new
  file_line = []
  args      = []

  File.foreach(read_file) { |line| file_line = line.strip.split }
  File.foreach(read_file) { |line| args = line }

  if file_line.reverse[0] =~ /\d$/ && file_line.reverse[1] =~ /\d$/
    arg3, arg2 = file_line.reverse[0], file_line.reverse[1]
    args = args.gsub(arg2, '')
    args = args.gsub(arg3, '').strip
    args = [args, arg2, arg3]
  elsif file_line.reverse[0] =~ /\d$/
    arg2 = file_line.reverse[0]
    args = args.gsub(arg2, '').strip
    args = [args, arg2]
  end

  encrypted = enigma.encrypt(*args)

  File.open(write_file, 'w') { |file| file.write( "#{encrypted[:encryption]}") }
  puts "Created \'#{write_file}\' with the key #{encrypted[:key]} and date #{encrypted[:date]}"
else
  puts "Can't find that file, love."
end
