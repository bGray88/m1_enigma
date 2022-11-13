class Enigma
  def initialize
    @encrypt = Encrypt.new
  end

  def encrypt(message, key = nil, date = nil)
    @encrypt.process(message, key, date)
  end
end
