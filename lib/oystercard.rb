class Oystercard
  MAX_BALANCE = 90
  attr_reader :balance
  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "Maximum balance of #{MAX_BALANCE} exceed" if max_balance_exceed?(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  private

  def max_balance_exceed?(amount)
    @balance + amount > MAX_BALANCE
  end
end
