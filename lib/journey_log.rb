require_relative "journey"

class JourneyLog
  attr_reader :journeys

  def initialize(journey = Journey.new)
    @journeys = []
    @current_journey = journey
  end


  def new_journey
    journey = Journey.new
    @journeys << journey
    journey
  end

  private

  def current_journey
    @current_journey
  end

end
