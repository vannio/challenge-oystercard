class Oystercard

	attr_reader :balance

	MAX_BALANCE = 90

	def initialize
		@balance = 0
		@in_journey = false
	end

	def topup(value)
    fail "Balance exceeded limit of #{MAX_BALANCE}" if (balance + value) > MAX_BALANCE
		@balance += value
	end

  def deduct(value)
    @balance -= value
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
