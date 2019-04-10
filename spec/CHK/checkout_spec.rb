require_solution 'CHK'

# +------+-------+------------------------+
# | Item | Price | Special offers         |
# +------+-------+------------------------+
# | A    | 50    | 3A for 130, 5A for 200 |
# | B    | 30    | 2B for 45              |
# | C    | 20    |                        |
# | D    | 15    |                        |
# | E    | 40    | 2E get one B free      |
# +------+-------+------------------------+

describe Checkout do
  it 'returns total checkout value of the items "ABCD"' do
    expect(Checkout.new.checkout('ABCD')).to eq(50 + 30 + 20 + 15)
  end

  it 'correctly discounts "AAAA"' do
    expect(Checkout.new.checkout('AAAA')).to eq(50 + 50 + 50 + 50 - 20)
  end

  it 'correctly discounts "BBBB" - i.e. 2x 2B ' do
    expect(Checkout.new.checkout('BBBB')).to eq(30 + 30 + 30 + 30 - 15 - 15)
  end

  it 'returns correct total checkout value for "AAAABBBCD"' do
    expect(Checkout.new.checkout('AAAABBBCD')).to eq((50 * 4) + (30 * 3) + 20 + 15 - 20 - 15)
  end

  # it 'handles lowercase SKU by upcase-ing them: "aaabcd"' do
  #   expect(Checkout.new.checkout('aaabcd')).to eq((50 * 3) + 30 + 20 + 15 - 20)
  # end

  # it 'ignores all non-alphabetic characters in the input string' do
  #   expect(Checkout.new.checkout('-A= b ')).to eq 80
  # end

  # Missed the note!
  # For any illegal input return -1

  it 'any illegal input will return -1' do
    expect(Checkout.new.checkout('AxA')).to eq(-1)
  end

  # free item is added by user, not checkout... so discount it
  it 'buying 2E gets you one B free' do
    expect(Checkout.new.checkout('EEB')).to eq 80
  end
end

