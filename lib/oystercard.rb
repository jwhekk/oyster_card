class Oystercard

	attr_reader :balance, :entry_station, :exit_station, :history, :journey
	#def balance
	#  @balance
	#end

	MAXIMUM_BALANCE = 90
	MINIMUM_BALANCE = 1
  MINIMUM_FARE = 3

	def initialize
		@balance = 0
		#@in_journey = false
    @history = []
	end

	def top_up num
		raise "Maximum balance of #{MAXIMUM_BALANCE} is exceeded" if (balance + num) > MAXIMUM_BALANCE
		@balance += num
	end

	def in_journey?
		#@in_journey
		# if @entry_station != nil
		# 	true
		# else #@entry_station == nil
		# 	false
		# end

		entry_station != nil ? true : false # Ternary Operator

		# !!@entry_station
		# '!!' evalutes the following expression 
		# If the expression evalutes to 'true', it returns true
		# If the expression evaluates to 'false', it returns false
		# Only two objects in Ruby that evaluate to 'false':
		# nil
		# false
	end

	def touch_in(entry_station)
		fail 'Your balance is not enough' if balance < MINIMUM_BALANCE
		@entry_station = entry_station
		#@in_journey = true
    start_journey
	end

	def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
		#@in_journey = false
    end_journey
    @entry_station = nil
	end

  def start_journey
    @journey = {}
    @journey[entry_station] = nil # started a journey (incomplete)
  end

  def end_journey
    @journey[entry_station] = exit_station # ended our journey (complete)
    history.push(@journey)
  end

  private

  def deduct num
    @balance -= num #=> @balance = @balance - num
  end
end
