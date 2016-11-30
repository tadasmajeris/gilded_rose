require_relative '../lib/gilded_rose'
require_relative '../lib/item'

describe GildedRose do

  let(:brie) { Item.new('Aged Brie', 3, 0) }
  let(:passes) { Item.new('Backstage passes to a TAFKAL80ETC concert', 3, 3) }
  let(:shovel) { Item.new('shovel', 2, 3) }
  let(:broken_shovel) { Item.new('broken_shovel', 1, 0) }
  let(:perfect_brie) { Item.new('perfect_brie', 2, 50) }
  let(:sulfuras) { Item.new('Sulfuras, Hand of Ragnaros', 0, 80) }
  let(:inn) { GildedRose.new([brie, passes, shovel, broken_shovel, perfect_brie]) }

  describe "#update_quality" do
    it "does not change the name" do
      inn.update_quality
      item = inn.items.first
      expect(item.name).to eq "Aged Brie"
    end
  end

  describe '#degrading_quality?' do

    it 'returns false if items name is "Aged Brie"' do
      expect(inn.degrading_quality?(brie)).to be false
    end

    it 'returns false if items name is "Backstage passes to a TAFKAL80ETC concert"' do
      expect(inn.degrading_quality?(passes)).to be false
    end

    it 'returns false if items name is "Sulfuras, Hand of Ragnaros"' do
      expect(inn.degrading_quality?(sulfuras)).to be false
    end

    it 'returns true if item is of degrading quality' do
      expect(inn.degrading_quality?(shovel)).to be true
    end
  end

  describe '#degrade' do
    it 'degrades items quality by 1' do
      expect { inn.degrade(shovel) }.to change { shovel.quality }.by(-1)
    end

    it 'cant degrade to less than 0 quality' do
      expect { inn.degrade(broken_shovel) }.not_to change { broken_shovel.quality }
    end
  end

  describe '#upgrade' do
    it 'upgrades items quality by 1' do
      expect { inn.upgrade(brie) }.to change { brie.quality }.by(1)
    end

    it 'cant upgrade to more than 50 quality' do
      expect { inn.upgrade(perfect_brie) }.not_to change { perfect_brie.quality }
    end
  end

end
