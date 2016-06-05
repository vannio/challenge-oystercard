require "record"

describe Record do
  let(:station) { double(:station) }

  it "on initialize it creates an empty array" do
    subject { described_class.new }
    expect(subject.history).to eq([])
  end

  describe "#start" do
    it "should change the state of journey" do
      expect { subject.start(station) }.to change { subject.journey }
    end
  end

  describe "#finish" do
    it "should record a completed journey" do
      subject.start(station)
      expect { subject.finish(station) }.to change { subject.history }
    end
  end
end
