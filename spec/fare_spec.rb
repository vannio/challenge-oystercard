require "fare"

describe Fare do
  let(:zone_2_station) { double(:station, zone: 2) }
  let(:zone_5_station) { double(:station, zone: 5) }

  describe "#calculate" do
    it "should calculate the fare for a single-zone journey" do
      expect(subject.calculate(zone_2_station, zone_2_station)).to eq 1
    end

    it "should calculate the fare for a four-zone journey" do
      expect(subject.calculate(zone_2_station, zone_5_station)).to eq 4
    end

    it "should return a penalty fare if there is no entry-zone" do
      expect(subject.calculate(nil, zone_2_station)).to eq described_class::PENALTY_FARE
    end
  end
end
