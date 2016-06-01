require_relative "journey"

class JourneyLog
  attr_reader :logs

  def initialize
    @logs = []
  end

  def new_journey
    journey = Journey.new
    @logs << journey
    journey
  end
end
