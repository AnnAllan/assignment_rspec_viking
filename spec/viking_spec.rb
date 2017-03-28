require 'viking'
describe Viking do
  let(:viking) {Viking.new}

  describe '#init' do
    it 'passes name to new Viking that sets name attribute' do
      vik = Viking.new("Oleg")
      expect(vik.name).to eq("Oleg")
    end
    it 'passes health to new Viking that sets health attribute' do
      allow(viking).to receive(:health).and_return(86)
      expect(viking.health).to eq(86)
    end
    it 'does not allow health to be overwritten after set on init' do
      allow(viking).to receive(:health).and_return(86)
      expect{viking(:health => 77)}.to raise_error(ArgumentError)
    end
    it 'sets weapon to nil by default' do
      expect(viking.weapon).to be_nil
    end
  end
  describe '#pick_up_weapon' do
    it 'sets weapon to Viking upon pick up' do
      viking.pick_up_weapon(Axe.new)
      expect(viking.weapon.name).to eq("Axe")
    end
    it 'raises exception if weapon argument is not of Weapon class' do
      expect{viking.pick_up_weapon("towel")}.to raise_error(RuntimeError, "Can't pick up that thing")
    end
    it 'replaces new weapon for Viking upon pick up' do
      vik = Viking.new(:weapon => Axe.new)
      vik.pick_up_weapon(Bow.new)
      expect(vik.weapon.name).to eq("Bow")
    end
  end
  describe '#drop_weapon' do
    it 'leaves Viking weaponless' do
      vik = Viking.new(:weapon => Axe.new)
      vik.drop_weapon
      expect(vik.weapon).to be_nil
    end
  end
  describe '#receive_attack' do
    it 'reduces Viking health by specified amount' do
      viking.receive_attack(10)
      expect(viking.health).to eq(90)
    end
    it 'calls #take_damage method' do
      expect(viking).to receive(:take_damage)
      viking.receive_attack(10)
    end
  end
  describe '#attack' do
    it 'causes recipient health to drop' do
      vik = Viking.new("Vik")
      vic = Viking.new("Vicki")
      vic.attack(vik)
      expect(vik.health).to be < 100
    end
    it 'calls recipient Viking #take_damage method' do
      vik = Viking.new("Vik")
      vic = Viking.new("Vicki")
      expect(vik).to receive(:take_damage)
      vic.attack(vik)
    end
    it 'runs #damage_with_fists when called with no weapon' do
      vik = Viking.new("Vik")
      vic = Viking.new("Vicki")
      vic.attack(vik)
      expect(vik.health).to eq(97.5)
    end
    it 'deals Fists multiplier times strength damage' do
      vik = Viking.new("Vik")
      vic = Viking.new("Vicki")
      vic.attack(vik)
      expect(vik.health).to eq(97.5)
    end
    it 'runs #damage_with_weapon when called with a weapon' do
      vik = Viking.new("Vik")
      vic = Viking.new("Vicki")
      vic.pick_up_weapon(Axe.new)
      vic.attack(vik)
      expect(vik.health).to eq(90)
    end
    it 'deals damage equal to Viking strength times weapon multiplier when called with a weapon' do
      vik = Viking.new("Vik")
      vic = Viking.new("Vicki")
      vic.attack(vik)
      expect(vik.health).to eq(97.5)
    end
    it 'uses Fists when attacking with Bow and 0 arrows' do
      vik = Viking.new("Vik")
      vic = Viking.new("Vicki")
      vic.pick_up_weapon(Bow.new(0))
      vic.attack(vik)
      expect(vik.health).to eq(97.5)
    end
    it 'raises error when Viking killed' do
      vik = Viking.new("Vik")
      vic = Viking.new("Vicki")
      expect{40.times{vic.attack(vik)}}.to raise_error(RuntimeError, "Vik has Died...")
    end
  end

end #Viking
