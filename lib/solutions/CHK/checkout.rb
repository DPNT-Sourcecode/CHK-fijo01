# noinspection RubyUnusedLocalVariable
class Checkout
  attr_reader :item_list

  def initialize
    @prices = {
      'A' => 50,
      'B' => 30,
      'C' => 20,
      'D' => 15,
      'E' => 40,
      'F' => 10
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
  # | F    | 10    | 2F get one F free      |
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

    discount += specials_a
    discount += specials_b
    discount += specials_f

    discount
  end

  def specials_a
    a_discounts = 0
    quantity_of_a = @item_list.count('A')

    if quantity_of_a >= 5
      discount_5a = quantity_of_a / 5
      a_discounts += (discount_5a * 50)
      quantity_of_a -= discount_5a * 5
    end

    # Refactored to reduce LOC:
    (quantity_of_a / 3).times { a_discounts += 20 }

    a_discounts
  end

  def specials_b
    number_of_b = @item_list.count('B')
    free_b = @item_list.count('E') / 2
    b_discounts = 0

    # Free B when you buy 2E is a b_discount:
    # But only discount B if one is checked out!

    unless number_of_b.zero?
      free_b.times { b_discounts += @prices['B'] }
    end

    # Now handle remainder B:
    remaining_b = number_of_b - free_b
    (remaining_b / 2).times { b_discounts += 15 }

    b_discounts
  end

  def specials_f
    number_of_f = @item_list.count('F')
    f_discounts = 0

    number_of_f.times { |f| (f_discounts += @prices['F']) if ((f + 1) % 3).zero? }

    f_discounts
  end
end
