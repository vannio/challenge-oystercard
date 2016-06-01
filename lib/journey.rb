class Journey

  PENALTY_FARE = 6
  MINIMUM_FARE = 1
  attr_reader :entry_station, :exit_station

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
  end

  def in_journey?
    entry_station && !exit_station
  end

  def fare
    return MINIMUM_FARE if complete?
    PENALTY_FARE
  end

  private

  def complete?
    !!entry_station && !!exit_station
  end
end
