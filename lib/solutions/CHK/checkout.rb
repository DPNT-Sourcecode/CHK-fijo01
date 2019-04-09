# noinspection RubyUnusedLocalVariable
class Checkout
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
    checkout_value -= discounts(@item_list)

    checkout_value
  end

  def discounts(item_list)
    discount = 0

    quantity_of_A = @item_list.count('A')

    if quantity_of_A >= 5
      discount_5A = quantity_of_A / 5
      discount += (discount_5A * 50)
      quantity_of_A -= discount_5A * 5
    end

    if quantity_of_A >= 3
      discount_3A = quantity_of_A / 3
      discount += (discount_3A * 20)
    end

    if @item_list.count('E')

    discount += (@item_list.count('B') / 2) * 15

    discount
  end
end








