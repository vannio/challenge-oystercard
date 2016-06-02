require_relative 'station'
require_relative 'journey'

class Oystercard
	BALANCE_LIMIT = 90
	MIN_LIMIT = 1
	FARE = 1

	attr_reader :balance, :previous_journeys, :current_journey

	def initialize
		@balance = 0
		@in_journey = false
		@previous_journeys = []
		@current_journey = Journey.new
	end

	def top_up(amount)
		fail "Can't add to your balance; would breach the £#{Oystercard::BALANCE_LIMIT} limit" if @balance + amount > BALANCE_LIMIT
		@balance += amount
		self
	end

	def touch_in(station)
		fail "Can't touch in your balance is below £#{Oystercard::MIN_LIMIT}" if @balance < MIN_LIMIT
		@current_journey.entry_station = station
		self
	end

	def touch_out(station)
		@current_journey.exit_station = station
		@previous_journeys << @current_journey
		@current_journey = Journey.new
		deduct(FARE)
		self
	end

	private

	def deduct(amount)
		@balance -= amount
	end

end
