class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  ERROR = {
    exceed_limit: "Balance is over the maximum limit of £#{MAXIMUM_BALANCE}",
    insufficient_funds: "Balance is too low. Please top up."
  }

  attr_reader :balance, :entry_station, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    fail (ERROR[:exceed_limit]) if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station = nil)
    fail ERROR[:insufficient_funds] unless enough_funds?
    @entry_station = station
  end

  def touch_out(station = nil)
    deduct_fare(MINIMUM_FARE)
    update_history(@entry_station, station)
    @entry_station = nil
  end

  def in_journey?
    @entry_station
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

    def update_history(entry_station, exit_station)
      @journey_history << { start: entry_station, end: exit_station }
    end
end
