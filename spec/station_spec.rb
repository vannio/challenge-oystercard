require "station"

describe Station do
  subject(:station) { described_class.new }

  it "has a name" do
    expect(station.name).to_not be nil
  end

  it "has a zone" do
    expect(station.zone).to_not be nil
  end
end
