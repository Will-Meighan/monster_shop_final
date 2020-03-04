class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || {}
    @contents.default = 0
  end

  def add_item(item_id)
    @contents[item_id] += 1
  end

  def less_item(item_id)
    @contents[item_id] -= 1
  end

  def count
    @contents.values.sum
  end

  def items
    @contents.map do |item_id, _|
      Item.find(item_id)
    end
  end

  def grand_total
    grand_total = 0.0
    @contents.each do |item_id, quantity|
      grand_total += Item.find(item_id).price * quantity
    end
    grand_total
  end

  def count_of(item_id)
    @contents[item_id.to_s]
  end

  def subtotal_of(item_id)
    @contents[item_id.to_s] * Item.find(item_id).price
  end

  def limit_reached?(item_id)
    count_of(item_id) == Item.find(item_id).inventory
  end

  def discount_info
    display = []
    self.contents.sum do |item_id,quantity|
      item = Item.find(item_id)
      possible_discounts = Discount.where(merchant_id: item.merchant_id)
                      .where("item_threshold <= #{quantity}")
                      .order("percent_discount DESC")
                      .limit(1)
      if possible_discounts.length > 0
        display << ((item.price * (1 - (possible_discounts[0].percent_discount.to_f/100))) * quantity).round(2)
        display << (possible_discounts[0].percent_discount)
      else
        item.price * quantity
      end
      display
    end
  end

end
