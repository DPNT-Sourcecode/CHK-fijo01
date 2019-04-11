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

  # Missed the note!
  # For any illegal input return -1

  it 'any illegal input will return -1' do
    expect(Checkout.new.checkout('AxA')).to eq(-1)
  end

  # free item is added by user, not checkout... so discount it
  it 'buying 2E gets you the B free, if B also purchased' do
    expect(Checkout.new.checkout('EEB')).to eq 80
  end

  it 'correctly prices group specials' do
    expect(Checkout.new.checkout('XYZ')).to eq 45
  end
end
