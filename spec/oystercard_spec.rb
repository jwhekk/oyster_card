require 'oystercard'

describe OysterCard do
  let(:station) { double(:station)}
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

    it  { is_expected.to respond_to(:touch_in).with(1).argument }

		it "stores the entry station" do
			subject.touch_in(station)
			expect(subject.entry_station).to eq station
		end

		it "clears enty_station" do
			subject.touch_in(station)
			subject.touch_out
			expect(subject.entry_station).to eq nil
		end

		it 'in_journey is true after touch in' do
			subject.touch_in(station)
			expect(subject).to be_in_journey
		end

		it 'in_journey is false after touch out' do
			subject.touch_out
			expect(subject).not_to be_in_journey
		end

    it 'deducts #{OysterCard::MIN_FARE} fare' do
			subject.touch_in(station)
			expect{subject.touch_out}.to change{subject.balance}.by(-1)
		end

	end

	  it "require a minimum fare of 1" do
      expect{ subject.touch_in(station)}.to raise_error "minimum fare is #{OysterCard::MIN_FARE} pound"
    end

end
