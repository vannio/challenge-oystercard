require 'journey'


describe Journey do
  let (:station) {double :station}
  subject(:journey) {described_class.new}

  context "given an entry station" do
    subject(:journey) {described_class.new(station)}
    it "has an entry station" do
      expect(journey.entry_station).to eq station
    end
  end
end
