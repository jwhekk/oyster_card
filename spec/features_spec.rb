require 'oystercard'

describe Oystercard do
  it 'initializes with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'tops up the card by the amount passed to it' do
    expect{subject.top_up(10)}.to change{subject.balance}.from(0).to(10)
  end

  it 'raises an error if balance is exceed' do
    subject.top_up(Oystercard::MAX_BALANCE)
    expect{subject.top_up(1)}.to raise_error "Maximum balance of #{Oystercard::MAX_BALANCE} exceed"
  end
end