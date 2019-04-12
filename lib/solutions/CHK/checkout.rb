# noinspection RubyUnusedLocalVariable
class Checkout
  attr_reader :item_list

  def initialize
    @prices = {
      'A' => 50, 'B' => 30, 'C' => 20, 'D' => 15, 'E' => 40, 'F' => 10,
      'G' => 20, 'H' => 10, 'I' => 35, 'J' => 60, 'K' => 70, 'L' => 90,
      'M' => 15, 'N' => 40, 'O' => 10, 'P' => 50, 'Q' => 30, 'R' => 50,
      'S' => 20, 'T' => 20, 'U' => 40, 'V' => 50, 'W' => 20, 'X' => 17,
      'Y' => 20, 'Z' => 21
    }

    @prices.default = 0
    @item_list = []
  end

  def checkout(skus)
    return -1 unless /^[A-Z]*$/ === skus

    checkout_value = 0
    @item_list = skus.chars.sort

    @item_list.each { |item| checkout_value += @prices[item] }

    checkout_value -= group_specials

    checkout_value -= special_offers

    checkout_value
  end

  def group_specials
    group_discount = 0

    discount_group = get_discount_group

    # Apply the discount to reduce each group to cost 45
    discount_group.each_slice(3) do |discounted_group|
      group_discount += (checkout(discounted_group) - 45)
    end

    group_discount
  end

  def get_discount_group
    discount_group = []
    discount_group = @item_list.select! { |item| ['S', 'T', 'X', 'Y', 'Z'].include?(item) }
    # Z = 21, Y = 20, T = 20, S = 20, X = 17

    # Discount only in groups of 3, extra items go back in list
    (discount_group.count % 3).times do
      if discount_group.include?('Z')
        @item_list.push(discount_group.delete_at(index('Z')))
        next
      elsif discount_group.include?('Y')
        @item_list.push(discount_group.delete_at(index('Y')))
        next
      elsif discount_group.include?('T')
        @item_list.push(discount_group.delete_at(index('T')))
        next
      elsif discount_group.include?('S')
        @item_list.push(discount_group.delete_at(index('S')))
        next
      elsif discount_group.include?('X')
        @item_list.push(discount_group.delete_at(index('X')))
        next
      end
    end

    discount_group
  end

  def special_offers
    discount = 0

    discount += specials_a
    discount += specials_b
    discount += specials_f
    discount += specials_h
    discount += specials_k
    discount += specials_m
    discount += specials_p
    discount += specials_q
    discount += specials_u
    discount += specials_v

    discount
  end

  def specials_a
    a_discounts = 0
    quantity_of_a = @item_list.count('A')

    # if quantity_of_a >= 5
    #   discount_5a = quantity_of_a / 5
    #   a_discounts += (discount_5a * 50)
    #   quantity_of_a -= discount_5a * 5
    # end

    # Refactored ln 76-80 to reduce LOC:
    (quantity_of_a / 5).times do
      a_discounts += 50
      quantity_of_a -= 5
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

  def specials_h
    h_discounts = 0
    quantity_of_h = @item_list.count('H')

    if quantity_of_h >= 10
      discount_10h = quantity_of_h / 10
      h_discounts += (discount_10h * 20)
      quantity_of_h -= discount_10h * 10
    end

    (quantity_of_h / 5).times { h_discounts += 5 }

    h_discounts
  end

  def specials_k
    k_discounts = 0
    @item_list.count('K').times { |k| (k_discounts += 20) if ((k + 1) % 2).zero? }
    k_discounts
  end

  def specials_m
    number_of_m = @item_list.count('M')
    free_m = @item_list.count('N') / 3
    m_discounts = 0

    # Free M when you buy 3N is a m_discount:
    # But only discount M if one is checked out!

    unless number_of_m.zero?
      free_m.times { m_discounts += @prices['M'] }
    end

    m_discounts
  end

  def specials_p
    p_discounts = 0
    @item_list.count('P').times { |p| (p_discounts += 50) if ((p + 1) % 5).zero? }

    p_discounts
  end

  def specials_q
    number_of_q = @item_list.count('Q')
    free_q = @item_list.count('R') / 3

    q_discounts = 0

    unless number_of_q.zero?
      free_q.times do
        q_discounts += @prices['Q']
        number_of_q -= 1
      end
    end

    number_of_q.times { |q| (q_discounts += 10) if ((q + 1) % 3).zero? }
    q_discounts
  end

  def specials_u
    u_discounts = 0
    @item_list.count('U').times { |u| (u_discounts += @prices['U']) if ((u + 1) % 4).zero? }
    u_discounts
  end

  def specials_v
    quantity_of_v = @item_list.count('V')
    v_discounts = 0

    if quantity_of_v >= 3
      discount_3v = quantity_of_v / 3
      v_discounts += (discount_3v * 20)
      quantity_of_v -= discount_3v * 3
    end

    (quantity_of_v / 2).times { v_discounts += 10 }

    v_discounts
  end
end




