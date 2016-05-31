class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = 1
  MAX_LIM_ERR_MSG = "£#{MAXIMUM_LIMIT} is the maximum limit"
  MIN_LIM_ERR_MSG = "£#{MINIMUM_FARE} is the minimum limit"

  attr_reader :balance, :entry_station, :log

  def initialize
    @balance = 0
    @log = []
  end

  def top_up(amount)
    fail MAX_LIM_ERR_MSG if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail MIN_LIM_ERR_MSG if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @log << { entry: @entry_station, exit: station }
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
