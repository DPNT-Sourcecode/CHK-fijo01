require_solution 'CHK'

# +------+-------+----------------+
# | Item | Price | Special offers |
# +------+-------+----------------+
# | A    | 50    | 3A for 130     |
# | B    | 30    | 2B for 45      |
# | C    | 20    |                |
# | D    | 15    |                |
# +------+-------+----------------+

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

  it 'handles lowercase SKU by upcase-ing them: "aaabcd"' do
    expect(Checkout.new.checkout('aaabcd')).to eq((50 * 3) + 30 + 20 + 15 - 20)
  end
end
