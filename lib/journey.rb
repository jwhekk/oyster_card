class Journey
  PENALTY_FARE = 6
  attr_reader :journey
  def initialize
    @journey = {}
  end

  def store_entry_station(station)
    @journey[:entry_station] = station
    @journey
  end

  def store_journey(station)
    @journey[:exit_station] = station
    @journey
  end

  def fare
    1
  end

  def no_touch_in(station)
    @journey[:entry_station] = "No touch in"
    @journey[:exit_station] = station
    @journey
  end
end
