class Journey
  attr_accessor :entry_station, :exit_station

  def initialize
    @entry_station = nil
    @exit_station = nil
  end

  def in_journey?
    @entry_station && !@exit_station
  end

end
