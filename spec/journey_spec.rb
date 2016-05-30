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

  context "has ended" do
    it "confirms the journey is complete" do
      subject.complete_journey(exit_station)
      expect(subject.incomplete?).to be_falsey
    end

    it "should remember the exit station" do
      expect do
        subject.complete_journey(exit_station)
      end.to change { subject.exit_station }
    end
  end
end
