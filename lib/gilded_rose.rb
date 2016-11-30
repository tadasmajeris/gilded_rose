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
        if item.quality > 0
          if item.name != SULFURAS
            item.quality = item.quality - 1
          end
        end

      else

        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == PASSES
            if item.sell_in < 11
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
            if item.sell_in < 6
              if item.quality < 50
                item.quality = item.quality + 1
              end
            end
          end
        end

      end

      if item.name != SULFURAS
        item.sell_in = item.sell_in - 1
      end

      if item.sell_in < 0
        if item.name != BRIE
          if item.name != PASSES
            if item.quality > 0
              if item.name != SULFURAS
                item.quality = item.quality - 1
              end
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
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
    item.quality -= 1
  end
end
