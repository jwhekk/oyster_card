require 'oystercard'

describe OysterCard do

  it 'has a balance of zero' do
  	expect(subject.balance).to eq(0)
  end

  it { is_expected.to respond_to(:top_up).with(1).argument}

  it "can top_up the balance" do
    expect{subject.top_up(50)}.to change{ subject.balance }.to(50)
  end

  it "checks for maximum limit" do
  	expect{ subject.top_up(100) }.to raise_error "Card limit is #{OysterCard::CARD_LIMIT}"
<<<<<<< HEAD
=======
  end

  it { is_expected.to respond_to(:deduct).with(1).argument}

  it "can deduct from the balance" do
    subject.top_up(90)
    expect(subject.deduct(10)).to eq 80
  end

  it "check for sufficient funds" do
    expect{ subject.deduct(10)}.to raise_error "Insufficient funds"
>>>>>>> 4b01c38307daa7e217f9097ec06e05ce6fa95f96
  end
end
