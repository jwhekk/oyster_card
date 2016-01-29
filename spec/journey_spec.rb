require 'journey'

describe Journey do
  #subject(:journey) {described_class.new(entry_station: "Victoria")}
  subject(:journey) {described_class.new}
  MIN_FARE = 1
  # let(:station) {double :station}
  # let(:station2) {double :station2}

  # it 'has an entry station' do
  #   expect(journey.entry_station).to eq "Victoria"
  # end
  it {is_expected.to respond_to(:journey)}

  describe '#store_entry_station' do
    it {is_expected.to respond_to(:store_entry_station).with(1).argument}

    it 'returns the hash' do
      expect(journey.store_entry_station("Victoria")).to eq ({entry_station: "Victoria"})
    end
  end

  describe '#store_journey' do
    it {is_expected.to respond_to(:store_journey).with(1).argument}

    it 'returns the journey' do
      journey.store_entry_station("Victoria")
      expect(journey.store_journey("Kingston")).to eq ({entry_station: "Victoria", exit_station: "Kingston"})
    end
  end

  describe '#fare' do
    it 'returns minimum fare when journey complete' do
      expect(journey.fare).to eq MIN_FARE
    end

    # it 'returns penalty fare when forgetting to touch in' do
    #   journey.store_journey("Kingston")
    #   expect(journey.fare).to eq Journey::PENALTY_FARE
    # end
  end

  describe '#no_touch_in' do
    it {is_expected.to respond_to(:no_touch_in)}

    it 'returns exception in history' do
      expect(journey.no_touch_in("Kingston")).to eq ({entry_station: "No touch in", exit_station: "Kingston"})
    end
  end

  # describe '#no_touch_out' do
  #   it {is_expected.to respond_to(:no_touch_out)}

  #   it 'returns exception in history' do
  #     expect(journey.no_touch_out("Victoria")).to eq ({entry_station: "Victoria", exit_station: "Kingston"})
  #   end
  # end
end