class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  ERROR = {
    exceed_limit: "Balance is over the maximum limit of £#{MAXIMUM_BALANCE}",
    insufficient_funds: "Balance is too low. Please top up."
  }

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail (ERROR[:exceed_limit]) if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station = nil)
    fail ERROR[:insufficient_funds] unless enough_funds?
    @journeying = true
    @entry_station = station
  end

  def touch_out
    deduct_fare(MINIMUM_FARE)
    @journeying = false
    @entry_station = nil
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

    def deduct_fare(amount)
      @balance -= amount
    end
end
