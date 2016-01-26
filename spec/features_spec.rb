require 'oystercard'

describe Oystercard do
  it 'initializes with a balance of 0' do
  expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'tops up the card by the amount passed to it' do
      expect{subject.top_up(1)}.to change{subject.balance}.from(0).to(1)
    end

    it 'raises an error if balance is exceed' do
      subject.top_up(Oystercard::MAX_BALANCE)
      expect{subject.top_up(1)}.to raise_error "Maximum balance of #{Oystercard::MAX_BALANCE} exceed"
    end
  end

  describe '#deduct' do
  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card

    it 'deducts amount from the balance' do
      subject.top_up(1)
      expect{subject.deduct(1)}.to change{subject.balance}.from(1).to(0)
    end
  end

  # In order to get through the barriers.
  # As a customer
  # I need to touch in and out.

  it 'shows that you are in_journey when you touch in' do
    subject.touch_in
    expect(subject).to be_in_journey
  end

  it 'shows that you are not in_journey when you touch out' do
    subject.touch_out
    expect(subject).not_to be_in_journey
  end

end
