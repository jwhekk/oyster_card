class Oystercard
  MAX_BALANCE = 90
  MIN_FARE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    raise "Maximum balance of #{MAX_BALANCE} exceed" if max_balance_exceed?(amount)
    @balance += amount
  end

  def touch_in
    raise 'Insufficient funds' if insufficient_fund?
    @in_use = true
  end

  def touch_out
    @in_use = false
    deduct(MIN_FARE)
  end

  def in_journey?
    @in_use
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def max_balance_exceed?(amount)
    @balance + amount > MAX_BALANCE
  end

  def insufficient_fund?
    @balance < MIN_FARE
  end

end
