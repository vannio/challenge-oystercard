class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  ERROR = {
    exceed_limit: "Balance is over the maximum limit of £#{MAXIMUM_BALANCE}",
    insufficient_funds: "Balance is too low. Please top up."
  }

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail (ERROR[:exceed_limit]) if limit_exceeded?(amount)
    @balance += amount
  end

  def deduct_fare(amount)
    @balance -= amount
  end

  def touch_in
    fail ERROR[:insufficient_funds] unless enough_funds?
    @journeying = true
  end

  def touch_out
    @journeying = false
  end

  def in_journey?
    @journeying
  end

  private

    def limit_exceeded?(amount)
      @balance + amount > MAXIMUM_BALANCE
    end

    def enough_funds?
      @balance >= MINIMUM_FARE
    end
end
