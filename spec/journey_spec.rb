require "journey"
require "oystercard"

describe Journey do
  let (:entry_station) {double :station, :zone => 2}
  let(:exit_station) { double :station, :zone => 2 }

  context "given an entry station" do
    subject(:journey) {described_class.new(entry_station)}

    it "has an entry station" do
      expect(journey.entry_station).to eq(entry_station)
    end

    it "journey is complete" do
      expect(journey).not_to be_complete
    end

    it "returns itself when finished" do
      expect(journey.end_journey(exit_station)).to eq(journey)
    end
  end

  context "given an exit station" do
    subject(:journey) { described_class.new }

    before do
      journey.end_journey(exit_station)
    end

    it "has an exit station" do
      expect(journey.exit_station).to eq(exit_station)
    end

    it "journey is complete" do
      expect(journey).not_to be_complete
    end
  end

  context "given both an entry and exit station" do
    subject(:journey) { described_class.new(entry_station) }

    before do
      journey.end_journey(exit_station)
    end

    it "journey is complete" do
      expect(journey).to be_complete
    end
  end
end
