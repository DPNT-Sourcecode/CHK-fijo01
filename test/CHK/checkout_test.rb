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

  def test_price_F
    assert_equal 10, Checkout.new.checkout('F'), 'Correctly prices a single F'
  end

  def test_price_G
    assert_equal 20, Checkout.new.checkout('G'), 'Correctly prices a single G'
  end

  def test_price_H
    assert_equal 10, Checkout.new.checkout('H'), 'Correctly prices a single H'
  end

  def test_price_I
    assert_equal 35, Checkout.new.checkout('I'), 'Correctly prices a single I'
  end

  def test_price_J
    assert_equal 60, Checkout.new.checkout('J'), 'Correctly prices a single J'
  end

  def test_price_K
    assert_equal 80, Checkout.new.checkout('K'), 'Correctly prices a single K'
  end

  def test_price_L
    assert_equal 90, Checkout.new.checkout('L'), 'Correctly prices a single L'
  end

  def test_price_M
    assert_equal 15, Checkout.new.checkout('M'), 'Correctly prices a single M'
  end

  def test_price_N
    assert_equal 40, Checkout.new.checkout('N'), 'Correctly prices a single N'
  end

  def test_price_O
    assert_equal 10, Checkout.new.checkout('O'), 'Correctly prices a single O'
  end

  def test_price_P
    assert_equal 50, Checkout.new.checkout('P'), 'Correctly prices a single P'
  end

  def test_price_Q
    assert_equal 30, Checkout.new.checkout('Q'), 'Correctly prices a single Q'
  end

  def test_price_R
    assert_equal 50, Checkout.new.checkout('R'), 'Correctly prices a single R'
  end

  def test_price_S
    assert_equal 30, Checkout.new.checkout('S'), 'Correctly prices a single S'
  end

  def test_price_T
    assert_equal 20, Checkout.new.checkout('T'), 'Correctly prices a single T'
  end

  def test_price_U
    assert_equal 40, Checkout.new.checkout('U'), 'Correctly prices a single U'
  end

  def test_price_V
    assert_equal 50, Checkout.new.checkout('V'), 'Correctly prices a single V'
  end

  def test_price_W
    assert_equal 20, Checkout.new.checkout('W'), 'Correctly prices a single W'
  end

  def test_price_X
    assert_equal 90, Checkout.new.checkout('X'), 'Correctly prices a single X'
  end

  def test_price_Y
    assert_equal 10, Checkout.new.checkout('Y'), 'Correctly prices a single Y'
  end

  def test_price_Z
    assert_equal 50, Checkout.new.checkout('Z'), 'Correctly prices a single Z'
  end

  def test_special_5H
    assert_equal 45, Checkout.new.checkout('HHHHH'), 'discount 5 for 5H'
  end

  def test_special_10H
    assert_equal 80, Checkout.new.checkout('HHHHHHHHHH'), 'discount 20 for 10H'
  end

  def test_special_2K
    assert_equal 150, Checkout.new.checkout('KK'), 'discount 10 for 10H'
  end

  def test_3N
    assert_equal 120, Checkout.new.checkout('NNN'), '3N charged normally'
  end

  def test_special_3N_get_M
    assert_equal 120, Checkout.new.checkout('NNNM'), 'if 3N and M exists, M is free'
  end

  def test_special_5P
    assert_equal 200, Checkout.new.checkout('PPPPP'), 'Fifth P is free'
  end

  def test_special_3Q
    assert_equal 80, Checkout.new.checkout('QQQ'), '3Q for 80'
  end

  def test_3R
    assert_equal 150, Checkout.new.checkout('RRR'), '3R normally priced at 150'
  end

  def test_special_3R
    assert_equal 150, Checkout.new.checkout('RRRQ'), '3R get one Q free '
  end

  def test_3U
    assert_equal 120, Checkout.new.checkout('UUU'), '3U normally priced at 120'
  end

  def test_special_3U
    assert_equal 120, Checkout.new.checkout('UUUU'), '4U, 4th free, costs 120'
  end

  def test_special_2V
    assert_equal 90, Checkout.new.checkout('VV'), '2V for 90'
  end

  def test_special_3V
    assert_equal 130, Checkout.new.checkout('VVV'), '3V for 130'
  end

  def test_5V
    assert_equal 220, Checkout.new.checkout('VVVVV'), '3V for 130, 2V for 90'
  end

  def test_4V
    assert_equal 180, Checkout.new.checkout('VVVV'), 'Correct pricing of 4V (130+50)'
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

  def test_special_FF
    # Wording was bad. Free F always added by user added by the system:
    basket = Checkout.new.checkout('FFF')
    assert_equal 20, basket, 'Correctly prices two F (third is free)'
  end

  def test_two_special_FF
    basket = Checkout.new.checkout('FFFFFF')
    assert_equal 40, basket, '6F should be price of 4F'
  end

  def test_FFFF
    basket = Checkout.new.checkout('FFFF')
    assert_equal 30, basket, '4F, pay for 3F because third free'
  end

  # ["PPPPQRUVPQRUVPQRUVSU"],"id":"CHK_R4_001"}, expected: 740, got: 730
  def test_PPPPQRUVPQRUVPQRUVSU
    basket = Checkout.new.checkout('PPPPQRUVPQRUVPQRUVSU')
    # PPPPPP QQQ RRR S UUUU VVV
    # 250 + [80 + 150(Free Q?)]  + 30 + 120 + 130
    # Q=30
    assert_equal 740, basket, '4F, pay for 3F because third free'
  end
end








