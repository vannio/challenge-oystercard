require "journey"

describe Journey do
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }
  subject { described_class.new(entry_station) }

  describe "#initialize" do
    it "should remember the entry station" do
      expect(subject.entry_station).to eq(entry_station)
    end

    it "should not have an exit station (yet)" do
      expect(subject.exit_station).to be_nil
    end
  end

  describe "#fare" do
    it "should have a default penalty fare" do
      expect(subject.fare).to eq(described_class::PENALTY_FARE)
    end
  end

  describe "#complete_journey" do
    it "should remember the exit station" do
      expect do
        subject.complete_journey(exit_station)
      end.to change { subject.exit_station }
    end

    it "should update the fare" do
      expect do
        subject.complete_journey(exit_station)
      end.to change { subject.fare }
    end
  end

  describe "#incomplete?" do
    context "incomplete journey" do
      it "confirms the journey is not yet complete" do
        expect(subject.incomplete?).to be true
      end
    end

    context "complete journey" do
      it "confirms the journey is complete" do
        subject.complete_journey(exit_station)
        expect(subject.incomplete?).to be false
      end
    end
  end
end
