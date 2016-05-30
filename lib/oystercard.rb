class Oystercard
  MAXIMUM_BALANCE = 9000 # in pence
  ERROR = {
    exceed_limit: "Balance is over the maximum limit of £#{MAXIMUM_BALANCE / 100}"
  }

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail (ERROR[:exceed_limit]) if limit_exceeded?(amount)
    @balance += amount
  end

  def deduct_fare(amount)
    @balance -= amount
  end

  private

    def limit_exceeded?(amount)
      @balance + amount > MAXIMUM_BALANCE
    end
end
