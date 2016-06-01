
class Oystercard

	BALANCE_LIMIT = 90
	MIN_LIMIT = 1
	FARE = 1


	attr_reader :balance, :in_journey, :entry_station

	def initialize
		@balance = 0
		@in_journey = false
		@entry_station = nil
	end

	def in_journey?
		@entry_station
	end

	def top_up(amount)
		fail "Can't add to your balance; would breach the £#{Oystercard::BALANCE_LIMIT} limit" if @balance + amount > BALANCE_LIMIT
		@balance += amount
		self
	end

	def touch_in(station)
		fail "Can't touch in your balance is below £#{Oystercard::MIN_LIMIT}" if @balance < MIN_LIMIT
		@in_journey = true
		@entry_station = station
		self
	end

	def touch_out
		@in_journey = false
		@entry_station = nil
		deduct(FARE)
		self
	end

	private

	def deduct(amount)
		@balance -= amount
	end

end