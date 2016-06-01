require "journey"

describe Journey do
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }

  describe "#start" do
    it "responds to start" do
      expect(subject).to respond_to(:start).with(1).argument
    end

    it "stores entry station" do
      subject.start(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe "#finish" do
    it "responds to finish" do
      expect(subject).to respond_to(:finish).with(1).argument
    end

    it "stores exit station" do
      subject.finish(exit_station)
      expect(subject.exit_station).to eq exit_station
    end
  end

  describe "#in_journey?" do
    it "should not be in journey on initialization" do
      expect(subject).not_to be_in_journey
    end

    it "should be in journey after starting" do
      subject.start(entry_station)
      expect(subject).to be_in_journey
    end

    it "shouldn't be in journey after finishing" do
      subject.finish(exit_station)
      expect(subject).not_to be_in_journey
    end
  end

  describe "#fare" do
    it "should have a penalty fare if there is no start" do
      expect(subject.fare).to eq described_class::PENALTY_FARE
    end

    it "should have a default fare if journey is complete" do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.fare).to eq described_class::MINIMUM_FARE
    end
  end
end
