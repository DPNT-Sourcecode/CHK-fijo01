require_solution 'CHK'

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
