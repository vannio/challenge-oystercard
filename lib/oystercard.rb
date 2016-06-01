class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 1

  attr_reader :balance, :current_journey, :log

  def initialize
    @balance = 0
    @current_journey = Hash.new
    @log = []
  end

  def in_journey?
    !current_journey.empty?
  end

  def touch_in(station)
    fail "Error: minimum balance less than minimum fare. Top-up!" if @balance < MIN_FARE
    @current_journey = { entry_station: station }
    @log << @current_journey
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @current_journey[:exit_station] = station
    @current_journey = Hash.new
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} reached!" if balance + amount > MAX_BALANCE
    @balance += amount
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
