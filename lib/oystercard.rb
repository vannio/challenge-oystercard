require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 1
  MAX_FARE = 6

  attr_reader :balance, :current_journey, :log

  def initialize(journey = Journey.new)
    @balance = 0
    @current_journey = journey
    @log = []
  end

  def touch_in(station)
    fail "Error: minimum balance less than minimum fare. Top-up!" if @balance < MIN_FARE
    current_journey.start(station)
    deduct(MAX_FARE)
    update_log
  end

  def touch_out(station)
    current_journey.finish(station)
    if current_journey.fare == MAX_FARE
      deduct(MAX_FARE)
    else
      refund(MAX_FARE - current_journey.fare)
    end
    reset_journey
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} reached!" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  private

  def refund(amount)
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def reset_journey
    @current_journey = Journey.new
  end

  def update_log
    @log << @current_journey
  end
end
