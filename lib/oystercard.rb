class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  ERROR = {
    exceed_limit: "Balance is over the maximum limit of £#{MAXIMUM_BALANCE}",
    insufficient_funds: "Balance is too low. Please top up."
  }

  attr_reader :balance, :entry_station, :journey_history

  def initialize
    self.balance = 0
    self.journey_history = []
  end

  def top_up(amount)
    fail (ERROR[:exceed_limit]) if limit_exceeded?(amount)
    self.balance += amount
  end

  def touch_in(station = nil)
    fail ERROR[:insufficient_funds] unless enough_funds?
    self.entry_station = station
  end

  def touch_out(station = nil)
    deduct_fare(MINIMUM_FARE)
    update_history(entry_station, station)
    self.entry_station = nil
  end

  def in_journey?
    entry_station
  end

  private
    attr_writer :balance, :entry_station, :journey_history

    def limit_exceeded?(amount)
      self.balance + amount > MAXIMUM_BALANCE
    end

    def enough_funds?
      self.balance >= MINIMUM_FARE
    end

    def deduct_fare(amount)
      self.balance -= amount
    end

    def update_history(entry_station, exit_station)
      self.journey_history << { entry: entry_station, exit: exit_station }
    end
end
