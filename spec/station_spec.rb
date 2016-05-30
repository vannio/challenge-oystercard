require "station"

describe Station do
  subject { described_class.new("Manor House", 2) }

  describe "#initialize" do
    it "has a name on initialisation" do
      expect(subject.name).to eq("Manor House")
    end

    it "has a zone on initialisation" do
      expect(subject.zone).to be_integer
    end
  end
end
