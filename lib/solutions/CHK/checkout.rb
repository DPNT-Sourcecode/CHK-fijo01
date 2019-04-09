# noinspection RubyUnusedLocalVariable
class Checkout

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

    prices = {
      'A' => 50,
      'B' => 30,
      'C' => 20,
      'D' => 15
    }

    prices.default = 0

    item_list = skus.chars

    checkout_value -= discounts(item_list)

    item_list.each do |item|
      checkout_value += prices[item]
    end

    checkout_value
  end

  def discounts(item_list)
    discount = 0

    quantity_of_A = item_list.count('A')

    until (quantity_of_A / 3) == 0 do
      c
    end

    # discount += (item_list.count('A') / 3) * 20
    discount += (item_list.count('B') / 2) * 15

    discount
  end

end



