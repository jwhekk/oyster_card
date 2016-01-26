require 'oystercard'

describe OysterCard do

  it 'has a balance of zero' do
  	expect(subject.balance).to eq(0)
  end

  it { is_expected.to respond_to(:top_up).with(1).argument}

  it "can top_up the balance" do
    expect{subject.top_up(100)}.to change{ subject.balance }.to(100)
  end
end
