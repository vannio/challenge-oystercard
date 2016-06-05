require_relative "record"

class Oystercard
	attr_reader :balance, :journeys, :journey

	MAX_BALANCE = 90
  MIN_FARE = 1

	def initialize(record = Record.new)
		@balance = 0
		@in_journey = false
		@record = record
		@journeys = record.history
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
    fail "Insufficient balance" if balance < MIN_FARE
		if @journey
			deduct(@journey.fare)
			@journeys << journey.end_journey
		end
    @journey = @record.start(station)
  end

  def touch_out(station)
		@journey = @record.start if @journey == nil
    @journeys << @journey.end_journey(station)
		deduct(@journey.fare)
		@journey = nil
  end

	private

  def deduct(value)
    @balance -= value
  end
end
