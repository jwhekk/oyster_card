class Journey
  attr_reader :entry_station
  def initialize(entry_station: station)
    @entry_station = station
  end
end