require_relative 'oystercard'
require_relative 'fare'

class Journey

  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @exit_station = nil
  end

  def end_journey(station = nil)
    @exit_station = station
    self
  end

  def complete?
    entry_station && exit_station
  end

  def fare
    Fare.new.calculate(entry_station, exit_station)
  end
end
