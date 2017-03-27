require 'weapons/bow.rb'

describe Bow do
  let(:bow) {Bow.new}
  describe '#initialize' do
    it 'has a readable bow count' do
      expect(bow).to have_attributes(:arrows => a_value)
    end
    it 'starts with 10 arrows by default' do
      expect(bow.arrows).to eq(10)
    end
    it 'can be created with a specified number of arrows to start' do
      custom_bow = Bow.new(5)
      expect(custom_bow.arrows).to eq(5)
    end
  end #initialize

  describe '#use' do
    it 'reduces bow count by one upon use' do
      bow.use
      expect(bow.arrows).to eq(9)
    end
    it 'raises error if 0 arrows remain' do
      empty_quiver = Bow.new(0)
      expect{empty_quiver.use}.to raise_error(RuntimeError, "Out of arrows")
    end
  end # use

end # Bow
