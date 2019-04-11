# noinspection RubyResolve,RubyResolve
# rubocop:disable Naming/MethodName
require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

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

class ClientTest < Minitest::Test
  def test_price_A
    assert_equal 50, Checkout.new.checkout('A'), 'Knows the price of a single unit of A'
  end

  def test_new_special_A
    assert_equal 200, Checkout.new.checkout('AAAAA'), '5A costs 200 because a discount of 50 is applied'
  end

  def test_special_A
    assert_equal 130, Checkout.new.checkout('AAA'), '3A costs 130 because a discount of 20 is applied'
  end

  def test_price_B
    assert_equal 30, Checkout.new.checkout('B'), 'Knows the price of a single unit of B'
  end

  def test_special_B
    assert_equal 45, Checkout.new.checkout('BB'), '2B costs 45 because a discount of 15 is applied'
  end

  def test_price_C
    assert_equal 20, Checkout.new.checkout('C'), 'Knows the price of a single unit of C'
  end

  def test_price_D
    assert_equal 15, Checkout.new.checkout('D'), 'Knows the price of a single unit of D'
  end

  def test_price_E
    assert_equal 40, Checkout.new.checkout('E'), 'Knows the price of a single unit of E'
  end

  # Add failed deploy-tests
  def test_freeB
    assert_equal 80, Checkout.new.checkout('EEB'), 'When 2E, B is free'
  end

  def test_double_freeB
    assert_equal 160, Checkout.new.checkout('EEEEBB'), 'When 4E, 2B are free (better than the 2B special)'
  end

  def test_EE
    assert_equal 80, Checkout.new.checkout('EE'), 'When 2E, price normally. No discounts!'
  end

  def test_price_F
    assert_equal 10, Checkout.new.checkout('F'), 'Correctly prices a single F'
  end

  def test_special_FF
    # Wording was bad. Free F always added by user added by the system:
    basket = Checkout.new.checkout('FFF')
    assert_equal 20, basket, 'Correctly prices two F (third is free)'
  end

  def test_two_special_FF
    basket = Checkout.new.checkout('FFFFFF')
    assert_equal 40, basket, '6F should be price of 4F'
  end

  # def test_FF_extra_free
  #   # R2 wording was bad. *Now* the free F is added by the system:
  #   basket = Checkout.new
  #   basket.checkout('FF')
  #   assert_equal 3, basket.item_list.count('F'), 'Buy 2F, one F free)'
  # end

  # Result is: FAILED
  # Some requests have failed (6/46). Here are some of them:
  #  - {"method":"checkout","params":["FFF"],"id":"CHK_R3_040"}, expected: 20, got: 30
  #  - {"method":"checkout","params":["FFFF"],"id":"CHK_R3_041"}, expected: 30, got: 40
  #  - {"method":"checkout","params":["FFFFFF"],"id":"CHK_R3_042"}, expected: 40, got: 60
  # You have received a penalty of: 10 min
end



