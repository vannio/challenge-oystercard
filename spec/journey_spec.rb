require 'journey'
require 'oystercard'


describe Journey do
  let (:station) {double :station, :zone => 2}
  let(:other_station) { double :other_station, :zone => 2 }

  context "given an entry station" do

    subject(:journey) {described_class.new(station)}

    it "has an entry station" do
      expect(journey.entry_station).to eq station
    end

    it 'journey is complete' do
      expect(journey).not_to be_complete
    end

    it 'returns itself when finish' do
      expect(journey.end_journey(other_station)).to eq journey
    end
  end

  context "given an exit station" do

    subject(:journey) {described_class.new}

    before{journey.end_journey(other_station)}

    it 'has an exit station' do
        expect(journey.exit_station).to eq other_station
    end

    it 'journey is complete' do
      expect(journey).not_to be_complete
    end
  end

  context "given both an entry and exit station" do

    subject(:journey) {described_class.new(station)}

    before {journey.end_journey(other_station)}

    it 'journey is complete' do
      expect(journey).to be_complete
    end
  end
end
