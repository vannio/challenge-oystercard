class Journey
  attr_reader :current_journey

  def initialize
    @current_journey = Hash.new
  end

  def start(station)
    @current_journey[:entry_station] = station
  end

  def finish(station)
    @current_journey[:exit_station] = station
  end

  def in_journey?
    @current_journey[:entry_station] && !@current_journey[:exit_station]
  end
end
