require 'warmup'
describe Warmup do
  let(:warm) {Warmup.new}
  describe '#gets_shout' do
    it 'upcases a string' do
      allow(warm).to receive(:gets).and_return('hello')
      expect(warm.gets_shout).to eq('HELLO')
    end
    it 'puts upcased string to console' do
      allow(warm).to receive(:gets).and_return('hello')
      expect{warm.gets_shout}.to output("HELLO\n").to_stdout
    end
  end #gets_shout

  describe '#triple_size' do
    it 'triples size of array' do
      my_double = double(:size => 4 )
      expect(warm.triple_size(my_double)).to eq(12)
    end
  end #triple_size

  describe '#calls_some_methods' do
    let(:string) {"hello"}
    it 'receives the #upcase! call' do
      expect(string).to receive(:upcase!).and_return('HELLO')
      warm.calls_some_methods(string)
    end
    it 'receives the #reverse! call' do
      expect(string).to receive(:reverse!).and_return('OLLEH')
      warm.calls_some_methods(string)
    end
    it 'returns different object' do
      expect(string.inspect).to_not eq(warm.calls_some_methods(string).inspect)
    end
  end
end #Warmup Class
