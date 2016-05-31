class Oystercard

	attr_reader :balance

	MAX_BALANCE = 90

	def initialize
		@balance = 0
	end

	def topup(value)
    fail "Balance exceeded limit of #{MAX_BALANCE}" if (balance + value) > MAX_BALANCE
		@balance += value
	end

  def deduct
    @balance -= 1
  end
end
