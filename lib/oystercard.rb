require 'journey'

class Oystercard

	attr_reader :balance, :journeys, :journey

	MAX_BALANCE = 90
  MIN_FARE = 1

	def initialize
		@balance = 0
		@in_journey = false
		@journeys = []
		@journey = nil
	end

	def topup(value)
    fail "Balance exceeded limit of #{MAX_BALANCE}" if (balance + value) > MAX_BALANCE
		@balance += value
	end

  def in_journey?
  	journey ? true : false
  end

  def touch_in(station)
    fail 'insufficient balance' if balance < MIN_FARE
		@journeys << journey.finish if @journey
    @journey = Journey.new(station)
  end

  def touch_out(station)
    deduct(MIN_FARE)
		@journey = Journey.new if @journey == nil
    @journeys << @journey.finish
		@journey = nil
  end

	  private

	  def deduct(value)
	    @balance -= value
	  end

end
