class OysterCard
 CARD_LIMIT = 90
 attr_reader :balance

 def initialize
   @balance = 0
 end

 def top_up(value)
 	balance_expected = @balance + value
 		raise "Card limit is #{CARD_LIMIT}" if balance_expected > CARD_LIMIT
   @balance += value
 end

 def deduct(value)
   raise "Insufficient funds" if value > @balance
   @balance -= value
 end

end
