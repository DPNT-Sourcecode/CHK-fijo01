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
end

