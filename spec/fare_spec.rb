require 'fare'

describe Fare do
  let (:zonetwostation) {double :station, :zone => 2}
  let (:zonefivestation){double :station, :zone => 5}
  describe '#calculate' do
    it "should calculate the fare for a single-zone journey" do
      expect(subject.calculate(zonetwostation, zonetwostation)).to eq 1
    end
    it "should calculate the fare for a four-zone journey" do
      expect(subject.calculate(zonetwostation,zonefivestation)).to eq 4
    end
    it "should return a penalty fare if there is no entry-zone" do
      expect(subject.calculate(nil,zonetwostation)).to eq Fare::PENALTY_FARE
    end
  end
end