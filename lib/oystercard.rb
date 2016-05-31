class Oystercard

	attr_reader :balance

	MAX_BALANCE = 90

	def initialize
		@balance = 0
	end

	def topup(value)
		@balance += value
	end

end