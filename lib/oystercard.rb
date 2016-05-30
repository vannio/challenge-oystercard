require_relative "journey"

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  ERROR = {
    exceed_limit: "Balance is over the maximum limit of £#{MAXIMUM_BALANCE}",
    insufficient_funds: "Balance is too low. Please top up."
  }

  attr_reader :balance, :journey_history

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    fail (ERROR[:exceed_limit]) if limit_exceeded?(amount)
    self.balance += amount
  end

  def touch_in(station = nil)
    fail ERROR[:insufficient_funds] unless enough_funds?
    @current_journey = Journey.new(station)
    update_history
  end

  def touch_out(station = nil)
    deduct_fare(MINIMUM_FARE)
    @current_journey.complete_journey(station)
  end

  def in_journey?
    @current_journey.incomplete? if @current_journey
  end

  private
    attr_writer :balance, :journey_history

    def limit_exceeded?(amount)
      self.balance + amount > MAXIMUM_BALANCE
    end

    def enough_funds?
      self.balance >= MINIMUM_FARE
    end

    def deduct_fare(amount)
      self.balance -= amount
    end

    def update_history
      self.journey_history << @current_journey
    end
end
