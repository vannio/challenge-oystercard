
class Oystercard

	BALANCE_LIMIT = 90
	MIN_LIMIT = 1
	FARE = 1


	attr_reader :balance, :in_journey

	def initialize
		@balance = 0
		@in_journey = false
	end

	def top_up(amount)
		fail "Can't add to your balance; would breach the £#{Oystercard::BALANCE_LIMIT} limit" if @balance + amount > BALANCE_LIMIT
		@balance += amount
		self
	end


	

	def touch_in
		fail "Can't touch in your balance is below £#{Oystercard::MIN_LIMIT}" if @balance < MIN_LIMIT
		in_journey = true
		self
	end

	def touch_out
		@in_journey = false
		deduct(FARE)
		self
	end

	private

	def deduct(amount)
	@balance -= amount
	end

	def in_journey?
		@in_journey
	end

end