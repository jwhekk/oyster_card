require 'oystercard'

describe OysterCard do

	context "card balance" do
	  it 'has a balance of zero' do
	  	expect(subject.balance).to eq(0)
	  end

	  it { is_expected.to respond_to(:top_up).with(1).argument}

	  it "can top_up the balance" do
	    expect{subject.top_up(50)}.to change{ subject.balance }.to(50)
	  end

	  it "checks for maximum limit" do
	  	expect{ subject.top_up(100) }.to raise_error "Card limit is #{OysterCard::CARD_LIMIT}"
	  end

	  it { is_expected.to respond_to(:deduct).with(1).argument}

	  it "can deduct from the balance" do
	    subject.top_up(90)
	    expect(subject.deduct(10)).to eq 80
	  end

	  it "check for sufficient funds" do
	    expect{ subject.deduct(10)}.to raise_error "Insufficient funds"
	  end
	end

	context 'card operation' do

		it { is_expected.to respond_to(:touch_in)}

		it "#touch_in" do
			expect{subject.touch_in}.to change{subject.card_status}.to(true)
		end

		it { is_expected.to respond_to(:touch_out)}

		it "#touch_out" do
			expect{subject.touch_out}.to change{subject.card_status}.to(false)
		end

		it {is_expected.to respond_to(:in_journey?)}

		it 'in_journey is true after touch in' do
			subject.touch_in
			expect(subject).to be_in_journey
		end

		it 'in_journey is false after touch out' do
			subject.touch_out
			expect(subject).not_to be_in_journey
		end
	end



end
