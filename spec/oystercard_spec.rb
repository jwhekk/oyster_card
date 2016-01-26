require 'oystercard'

describe Oystercard do
  it 'responds to balance' do
    expect(subject).to respond_to :balance
  end

  it 'initializes with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'responds to top_up with 1 argument' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end
  end
end
