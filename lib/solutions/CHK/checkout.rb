# noinspection RubyUnusedLocalVariable
class Checkout
  attr_reader :item_list

  def initialize
    @prices = {
      'A' => 50, 'B' => 30, 'C' => 20, 'D' => 15, 'E' => 40, 'F' => 10,
      'G' => 20, 'H' => 10, 'I' => 35, 'J' => 60, 'K' => 80, 'L' => 90,
      'M' => 15, 'N' => 40, 'O' => 10, 'P' => 50, 'Q' => 30, 'R' => 50,
      'S' => 30, 'T' => 20, 'U' => 40, 'V' => 50, 'W' => 20, 'X' => 90,
      'Y' => 10, 'Z' => 50
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
  # | G    | 20    |                        |
  # | H    | 10    | 5H for 45, 10H for 80  |
  # | I    | 35    |                        |
  # | J    | 60    |                        |
  # | K    | 80    | 2K for 150             |
  # | L    | 90    |                        |
  # | M    | 15    |                        |
  # | N    | 40    | 3N get one M free      |
  # | O    | 10    |                        |
  # | P    | 50    | 5P for 200             |
  # | Q    | 30    | 3Q for 80              |
  # | R    | 50    | 3R get one Q free      |
  # | S    | 30    |                        |
  # | T    | 20    |                        |
  # | U    | 40    | 3U get one U free      |
  # | V    | 50    | 2V for 90, 3V for 130  |
  # | W    | 20    |                        |
  # | X    | 90    |                        |
  # | Y    | 10    |                        |
  # | Z    | 50    |                        |
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



