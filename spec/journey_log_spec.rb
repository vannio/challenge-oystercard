require "journey_log"

describe JourneyLog do
  describe "#logs" do
    it "shows an empty journey history" do
      expect(subject.logs).to eq []
    end

    it "has a journey history" do
      subject.new_journey
      expect(subject.logs).to_not be_empty
    end
  end
end
