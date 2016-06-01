
class Oystercard

	BALANCE_LIMIT = 90

	attr_reader :balance, :in_journey

	def initialize
		@balance = 0
		@in_journey = false
	end

	def top_up(amount)
		fail "Can't add to your balance; would breach the £#{Oystercard::BALANCE_LIMIT} limit" if @balance + amount > BALANCE_LIMIT
		@balance += amount
	end

	# def limit_reached?(amount)
	# 	@balance + amount > BALANCE_LIMIT
	# end

	def deduct(amount)
		@balance -= amount
	end

	def in_journey?
		@in_journey
	end

	def touch_in
		fail "Can't touch in your balance is below £1" if @balance < 1
		@in_journey = true
	end

	def touch_out
		@in_journey = false
	end

end