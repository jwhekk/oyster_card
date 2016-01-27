require 'oystercard'

describe OysterCard do

  subject(:card) { described_class.new}
  let(:station) { double(:station)}

  context "card balance" do


	  it 'has a balance of zero' do
	  	expect(card.balance).to eq(0)
	  end

	  it "can top_up the balance" do
	    expect{card.top_up(50)}.to change{ card.balance }.to(50)
	  end

	  it "checks for maximum limit" do
	  	expect{ card.top_up(100) }.to raise_error "Card limit is #{OysterCard::CARD_LIMIT}"
	  end

	end

	context 'card operation' do
    before(:each) do

      card.top_up(1)
    end

    it  { is_expected.to respond_to(:touch_in).with(1).argument }
    it  { is_expected.to respond_to(:touch_out).with(1).argument }

		it "stores the entry station" do
			card.touch_in(station)
			expect(card.entry_station).to eq station
		end

		it "clears enty_station" do
			card.touch_in(station)
			card.touch_out(station)
			expect(card.entry_station).to eq nil
		end

		it 'in_journey is true after touch in' do
			card.touch_in(station)
			expect(card).to be_in_journey
		end

		it 'in_journey is false after touch out' do
			card.touch_out(station)
			expect(card).not_to be_in_journey
		end

    it 'has an empty history when initialised' do
      expect(card.history).to eq []
    end

    it 'stores the history of the journeys' do
      card.touch_in("Victoria")
      card.touch_out("Kingston")
      expect(card.history).to eq [{"Victoria"=>"Kingston"}]

    end

    it 'deducts #{OysterCard::MIN_FARE} fare' do
			card.touch_in(station)
			expect{card.touch_out(station)}.to change{card.balance}.by(-1)
		end

	end

	  it "require a minimum fare of 1" do
      expect{ card.touch_in(station)}.to raise_error "minimum fare is #{OysterCard::MIN_FARE} pound"
    end

end
