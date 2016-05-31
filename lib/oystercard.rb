class Oystercard

	attr_reader :balance, :journeys, :journey

	MAX_BALANCE = 90
  MIN_FARE = 1

	def initialize
		@balance = 0
		@in_journey = false
		@journeys = []
		@journey = {}
	end

	def topup(value)
    fail "Balance exceeded limit of #{MAX_BALANCE}" if (balance + value) > MAX_BALANCE
		@balance += value
	end

  def in_journey?
  	@journey.include?(:entry_station) && !@journey.include?(:exit_station)
  end

  def touch_in(station)
    fail 'insufficient balance' if balance < MIN_FARE
    @journey = {}
    @journey.store(:entry_station, station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journey.store(:exit_station, station)
    @journeys << journey
  end

	  private

	  def deduct(value)
	    @balance -= value
	  end

end
