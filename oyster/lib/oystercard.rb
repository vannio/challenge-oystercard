
class Oystercard

	attr_reader :balance

	def initialize
		@balance = 0
	end

	def top_up(amount)
		fail "Can't add to your balance; would breach the £90 limit" if limit_reached?(amount)
		@balance += amount
	end

	def limit_reached?(amount)
		@balance + amount > 90
	end

end