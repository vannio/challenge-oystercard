
class Oystercard

	attr_reader :balance, :in_journey

	def initialize
		@balance = 0
		@in_journey = false
	end

	def top_up(amount)
		fail "Can't add to your balance; would breach the £90 limit" if limit_reached?(amount)
		@balance += amount
	end

	def limit_reached?(amount)
		@balance + amount > 90
	end

	def deduct(amount)
		@balance -= amount
	end

	def in_journey?
		@in_journey
	end

	def touch_in
		@in_journey = true
	end

	def touch_out
		@in_journey = false
	end

end