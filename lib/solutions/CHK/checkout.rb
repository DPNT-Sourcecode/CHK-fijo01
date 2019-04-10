# noinspection RubyUnusedLocalVariable
class Checkout
  attr_reader :item_list

  def initialize
    @prices = {
      'A' => 50,
      'B' => 30,
      'C' => 20,
      'D' => 15,
      'E' => 40
    }

    @prices.default = 0
    @item_list = []
  end

  # +------+-------+------------------------+
  # | Item | Price | Special offers         |
  # +------+-------+------------------------+
  # | A    | 50    | 3A for 130, 5A for 200 |
  # | B    | 30    | 2B for 45              |
  # | C    | 20    |                        |
  # | D    | 15    |                        |
  # | E    | 40    | 2E get one B free      |
  # +------+-------+------------------------+

  def checkout(skus)
    return -1 unless /^[A-Z]*$/ === skus

    checkout_value = 0
    @item_list = skus.chars
    @item_list.each { |item| checkout_value += @prices[item] }
    checkout_value -= special_offers

    checkout_value
  end

  def special_offers
    discount = 0

    discount += specials_A
    discount += specials_B

    discount
  end

  def specials_A
    a_discounts = 0
    quantity_of_A = @item_list.count('A')
      
    if quantity_of_A >= 5
      discount_5A = quantity_of_A / 5
      a_discounts += (discount_5A * 50)
      quantity_of_A -= discount_5A * 5
    end
    
    # Refactored to reduce LOC:
      (quantity_of_A / 3).times { a_discounts += 20 }

    a_discounts
  end

  def specials_B
    b_discounts = 0

    # Free B when you buy 2E is a b_discount:
    free_b = @item_list.count('E') / 2
    free_b.times { b_discounts += @prices['B'] }
    # Now handle remainder B:
    remaining_b = @item_list.count('B') - free_b
    (remaining_b / 2).times { b_discounts += 15 }

    b_discounts
  end



end


