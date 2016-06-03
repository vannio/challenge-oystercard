require_relative 'journey'

class Record
  attr_reader :history, :journey

  def initialize
    @history = []
  end

  def start(station = nil)
    @journey = Journey.new(station)
  end

  def finish(station)
    @history << @journey.end_journey(station)
  end
end
