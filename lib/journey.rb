class Journey
  attr_reader :entry_station, :exit_station

  def initialize(entry_station)
    @entry_station = entry_station
    @exit_station
  end

  def complete_journey(exit_station)
    @exit_station = exit_station
  end

  def incomplete?
    !@exit_station
  end
end
