# noinspection RubyResolve,RubyResolve
require_relative '../test_helper'
require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout

require_solution 'CHK'

# +------+-------+----------------+
# | Item | Price | Special offers |
# +------+-------+----------------+
# | A    | 50    | 3A for 130     |
# | B    | 30    | 2B for 45      |
# | C    | 20    |                |
# | D    | 15    |                |
# +------+-------+----------------+

class ClientTest < Minitest::Test
  def test_price_A
    assert_equal 50, Checkout.new.checkout('A'), 'Knows the price of a single unit of A'
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
end