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
    checkout_value -= special_offers()
    
    checkout_value
  end
  
  def special_offers()
    discount = 0

    discount += specials_A
    discount += (@item_list.count('B') / 2) * 15

    specials_2E

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
    
    if quantity_of_A >= 3
      discount_3A = quantity_of_A / 3
      a_discounts += (discount_3A * 20)
    end

    a_discounts
  end

  def specials_2E
    (@item_list.count('E') / 2).times { @item_list.push('B') }
  end

end




