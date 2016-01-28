require 'oystercard'

describe Oystercard do
  let(:station)  { double :station }
  let(:station2) { double :station }
  let(:journey) { {:entry_station => station, :exit_station => station2} }
  
  before(:each) do
    allow(station).to receive(:name).and_return(station)
    allow(station2).to receive(:name).and_return(station2)
  end
  

  it 'initializes with a balance of 0' do
    expect(subject.balance).to eq 0
  end

  it 'history of jorneys is empty when initialized' do
    expect(subject.history).to be_empty
  end

  it 'stores one journey in history' do
    subject.top_up(Oystercard::MIN_FARE)
    subject.touch_in(station)
    subject.touch_out(station2)
    expect(subject.history).to include journey

  end

  describe '#top_up' do
    before do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
    end

    it 'tops up the card by the amount passed to it' do
      expect(subject.balance).to eq Oystercard::MIN_FARE
    end

    it 'raises an error if balance is exceed' do
      expect{subject.top_up(Oystercard::MAX_BALANCE)}.to raise_error "Maximum balance of #{Oystercard::MAX_BALANCE} exceed"
    end
  end

  describe '#touch_in' do
    # In order to get through the barriers.
    # As a customer
    # I need to touch in and out.

    it 'shows that you are in_journey when you touch in' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    # In order to pay for my journey
    # As a customer
    # I need to have the minimum amount (£1) for a single journey.
    it 'raises an error if you touch in without sufficient funds' do
      expect{subject.touch_in(station)}.to raise_error 'Insufficient funds'
    end
  end

  describe '#touch_out' do
    before do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
    end
    it 'shows that you are not in_journey when you touch out' do
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

  # In order to pay for my journey
  # As a customer
  # When my journey is complete, I need the correct amount deducted from my card
  it 'deducts min fare when touching out' do
    expect{subject.touch_out(station)}.to change{subject.balance}.by -Oystercard::MIN_FARE
  end
end

  describe '#deduct' do
  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card

    it 'deducts amount from the balance' do
      subject.top_up(Oystercard::MIN_FARE)
      subject.touch_in(station)
      expect{subject.touch_out(station)}.to change{subject.balance}.from(Oystercard::MIN_FARE).to(0)
    end
  end


  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from
  it 'remembers the entry station' do
    subject.top_up(Oystercard::MIN_FARE)
    expect{subject.touch_in(station)}.to change{subject.entry_station}.to ({:entry_station => station})
  end

  it 'resets the entry station when touching out' do
    subject.top_up(Oystercard::MIN_FARE)
    subject.touch_in(station)
    expect{subject.touch_out(station)}.to change{subject.entry_station}.to eq nil
  end
end
