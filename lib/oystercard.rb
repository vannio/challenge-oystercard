class Oystercard

  MAX_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Maximum balance of #{MAX_BALANCE} reached!" if balance + amount > MAX_BALANCE
    @balance += amount
  end
end