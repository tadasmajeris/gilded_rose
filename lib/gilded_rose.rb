class GildedRose

  def initialize(items)
    @items = items
  end

  BRIE = "Aged Brie"
  PASSES = "Backstage passes to a TAFKAL80ETC concert"
  SULFURAS = "Sulfuras, Hand of Ragnaros"
  UPGRADING_ITEMS = [BRIE, PASSES]

  def update_quality()

    @items.each do |item|

      if degrading_quality?(item)
        degrade(item)
      else
        upgrade(item)
        if item.name == PASSES
          upgrade(item) if item.sell_in < 11
          upgrade(item) if item.sell_in < 6
        end
      end

      if item.name != SULFURAS
        item.sell_in = item.sell_in - 1
      end

      if item.sell_in < 0
        if item.name == BRIE
          upgrade(item)
        elsif item.name == PASSES
          item.quality = 0
        else
          degrade(item)
        end
      end

    end

  end

  def items
    @items.dup
  end

  def degrading_quality?(item)
    !UPGRADING_ITEMS.include? item.name
  end

  def degrade(item)
    if item.name != SULFURAS && item.quality > 0
      item.quality -= 1
    end
  end

  def upgrade(item)
    item.quality += 1 if item.quality < 50
  end
end
