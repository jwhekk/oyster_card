require 'journey'

describe Journey do
  subject(:journey) {described_class.new(entry_station: station)}
  let(:station) {double :station}
  let(:station2) {double :station2}

  it 'has an entry station' do
    expect(journey.entry_station).to eq station
  end
end