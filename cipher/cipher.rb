class Cipher
  def self.encrypt(input, key)
    raise "input not 16 bits" unless input.length == 16
    raise "key not 80 bits" unless key.length == 80
    results = Round.forward(key[0,16], input)
    results = Round.forward(key[16,16], results)
    results = Round.forward(key[32,16], results)
    results = Round.forward(key[48,16], results , true)
    Xor.sum(results, key[64,16])
  end

  def self.decrypt(input, key)
    raise "input not 16 bits" unless input.length == 16
    raise "key not 80 bits" unless key.length == 80
    results = Xor.sum(input, key[64,16])
    results = Round.backward(key[48,16], results , true)
    results = Round.backward(key[32,16], results)
    results = Round.backward(key[16,16], results)
    Round.backward(key[0,16], results)
  end
end
