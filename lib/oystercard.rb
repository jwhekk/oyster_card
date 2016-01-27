class OysterCard
 CARD_LIMIT = 90
 MIN_FARE = 1
 attr_reader :balance, :entry_station, :history
 def initialize
   @balance = 0
   @history = []
 end

 def top_up(value)
 		balance_expected = @balance + value
 		raise "Card limit is #{CARD_LIMIT}" if balance_expected > CARD_LIMIT
   	@balance += value
 end

 def touch_in(station)
    @entry_station = station
  	raise "minimum fare is #{MIN_FARE} pound" if @balance < MIN_FARE
 end

 def touch_out(station)
   journey = {}
   journey[@entry_station] = station
   @history << journey
   @entry_station = nil
 	 deduct(MIN_FARE)
 
 end

 def in_journey?
 	!!entry_station
 end
 

private

 def deduct(value)
   raise "Insufficient funds" if value > @balance
   @balance -= value
 end

end
