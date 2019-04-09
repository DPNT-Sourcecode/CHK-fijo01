# noinspection RubyUnusedLocalVariable
class Checkout

# +------+-------+----------------+
# | Item | Price | Special offers |
# +------+-------+----------------+
# | A    | 50    | 3A for 130     |
# | B    | 30    | 2B for 45      |
# | C    | 20    |                |
# | D    | 15    |                |
# +------+-------+----------------+

  def checkout(skus)
    checkout_value = 0

    prices = {
      'A' => 50
    }

    item_list = skus.chars

    item_list.each do |item|
      checkout_value += prices[item]
    end

    checkout_value
  end

end





