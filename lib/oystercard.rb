class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "Error: minimum balance less than minimum fare. Top-up!" if @balance < MIN_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} reached!" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end
end