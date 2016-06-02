class Journey
  MIN_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    @entry_station && !@exit_station
  end

  def fare
    return PENALTY_FARE if incomplete_journey?
    MIN_FARE
  end

  private

  def incomplete_journey?
    (@entry_station and !@exit_station) or (!@entry_station and @exit_station)
  end
end
