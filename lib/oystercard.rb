class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_LIMIT = 1
  MAX_LIM_ERR_MSG = "£#{MAXIMUM_LIMIT} is the maximum limit"
  MIN_LIM_ERR_MSG = "£#{MINIMUM_LIMIT} is the minimum limit"

  attr_reader :balance, :in_journey
  alias in_journey? in_journey

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail MAX_LIM_ERR_MSG if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    fail MIN_LIM_ERR_MSG if @balance < MINIMUM_LIMIT
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
end
