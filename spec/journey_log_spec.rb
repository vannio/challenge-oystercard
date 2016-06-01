require "journey_log"

describe JourneyLog do
  describe "#journeys" do
    it "shows an empty journey history" do
      expect(subject.journeys).to eq []
    end

    it "has a journey history" do
      subject.new_journey
      expect(subject.journeys).to_not be_empty
    end
  end
end
