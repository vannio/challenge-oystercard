require_relative 'journey'

class JourneyLog
  def initialize
    @journeys = []
  end

  def start(station)
    @current_journey = @journey_class.new(station)
  end

end
