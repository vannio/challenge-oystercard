class Oystercard

	attr_reader :balance, :entry_station, :exit_station

	MAX_BALANCE = 90
  MIN_FARE = 1

	def initialize
		@balance = 0
		@in_journey = false
	end

	def topup(value)
    fail "Balance exceeded limit of #{MAX_BALANCE}" if (balance + value) > MAX_BALANCE
		@balance += value
	end

  def in_journey?
  	!!entry_station && !exit_station
  end

  def touch_in(station)
    fail 'insufficient balance' if balance < MIN_FARE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MIN_FARE)
		@exit_station = station
  end

  private

  def deduct(value)
    @balance -= value
  end

end
