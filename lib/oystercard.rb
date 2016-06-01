require_relative 'journey_log'

class Oystercard
  MAX_BALANCE = 90
  MIN_FARE = 1

  attr_reader :balance, :current_journey

  def initialize(journey_logs = JourneyLog.new)
    @balance = 0
    @journey_log = journey_logs
    @current_journey = @journey_log.new_journey
  end

  def touch_in(station)
    fail "Error: minimum balance less than minimum fare. Top-up!" if @balance < MIN_FARE
    current_journey.start(station)
    update_balance(current_journey.fare)
  end

  def touch_out(station)
    current_journey.finish(station)
    update_balance(current_journey.fare)
    reset_journey
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} reached!" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  private

  def update_balance(amount)
    @balance += amount
  end

  def reset_journey
    @current_journey = @journey_log.new_journey
  end
end
