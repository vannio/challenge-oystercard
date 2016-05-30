class Journey
  PENALTY_FARE = 6

  attr_reader :entry_station, :exit_station, :fare

  def initialize(entry_station)
    @fare = PENALTY_FARE
    @entry_station = entry_station
  end

  def complete_journey(exit_station)
    calculate_fare
    self.exit_station = exit_station
  end

  def incomplete?
    !exit_station
  end

  private

    attr_writer :fare, :exit_station

    def calculate_fare
      self.fare = 1
    end
end
