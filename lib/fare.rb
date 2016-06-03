class Fare
  PENALTY_FARE = 6
  MIN_FARE = 1

  def calculate(first = nil,second = nil)
    return PENALTY_FARE unless (first && second)
    (first.zone - second.zone).abs + MIN_FARE
  end
end