require "station"

describe Station do
  subject { described_class.new("Waterloo", 1) }

  describe "#name" do
    it "returns the name of the station" do
      expect(subject.name).to eq("Waterloo")
    end
  end

  describe "#zone" do
    it "returns the zone of the station" do
      expect(subject.zone).to eq(1)
    end
  end
end
