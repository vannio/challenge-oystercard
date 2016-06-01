class Journey
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  attr_reader :entry_station, :exit_station, :fare

  def initialize
    @fare = -PENALTY_FARE
  end

  def start(station)
    @entry_station = station
  end

  def finish(station)
    @exit_station = station
    recalculate_fare
  end

  def in_journey?
    entry_station && !exit_station
  end

  private

  def recalculate_fare
    @fare = (PENALTY_FARE - MINIMUM_FARE) if complete?
  end

  def complete?
    !!entry_station && !!exit_station
  end
end
