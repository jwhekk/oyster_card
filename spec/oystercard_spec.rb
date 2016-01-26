require 'oystercard'

describe OysterCard do

	context "card balance" do
	  it 'has a balance of zero' do
	  	expect(subject.balance).to eq(0)
	  end

	  it "can top_up the balance" do
	    expect{subject.top_up(50)}.to change{ subject.balance }.to(50)
	  end

	  it "checks for maximum limit" do
	  	expect{ subject.top_up(100) }.to raise_error "Card limit is #{OysterCard::CARD_LIMIT}"
	  end

	end

	context 'card operation' do
    before(:each) do
      subject.top_up(1)
    end

		it "#touch_in" do
			expect{subject.touch_in}.to change{subject.card_status}.to(true)
		end

		it "#touch_out" do
			expect{subject.touch_out}.to change{subject.card_status}.to(false)
		end

		it 'in_journey is true after touch in' do
			subject.touch_in
			expect(subject).to be_in_journey
		end

		it 'in_journey is false after touch out' do
			subject.touch_out
			expect(subject).not_to be_in_journey
		end

    it 'deducts #{OysterCard::MIN_FARE} fare' do
			subject.touch_in
			expect{subject.touch_out}.to change{subject.balance}.by(-1)
		end

	end

	  it "require a minimum fare of 1" do
      expect{ subject.touch_in}.to raise_error "minimum fare is #{OysterCard::MIN_FARE} pound"
    end

end
