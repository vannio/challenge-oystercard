require "journey"

describe Journey do
  let(:station) { double(:station) }

  it "should have no entry station on instantiation" do
    expect(subject.entry_station).to be_nil
  end

  it "should have no exit station on instantiation" do
    expect(subject.exit_station).to be_nil
  end

  it "should store a name of an entry station" do
    subject.entry_station = station
    expect(subject.entry_station).to eq station
  end

  it "should store a name of an exit station" do
    subject.exit_station = station
    expect(subject.exit_station).to eq station
  end

  describe "#in_journey?" do
    context "has neither entry nor exit stations" do
      it "should not be in journey" do
        expect(subject).to_not be_in_journey
      end
    end

    context "has an exit station" do
      before do
        subject.exit_station = station
      end

      it "should not be in journey" do
        expect(subject).to_not be_in_journey
      end
    end

    context "has an entry station but no exit station" do
      before do
        subject.entry_station = station
      end

      it "should be in journey" do
        expect(subject).to be_in_journey
      end
    end

    context "has both entry and exit station" do
      before do
        subject.entry_station = station
        subject.exit_station = station
      end

      it "should not be in journey" do
        expect(subject).to_not be_in_journey
      end
    end
  end

  describe "#fare" do
    context "is a complete journey (with entry and exit station)" do
      before do
        subject.entry_station = station
        subject.exit_station = station
      end

      it "should return the mimimum fare" do
        expect(subject.fare).to eq described_class::MIN_FARE
      end
    end

    context "has an entry station but no exit station" do
      before do
        subject.entry_station = station
      end

      it "should return the penalty fare" do
        expect(subject.fare).to eq described_class::PENALTY_FARE
      end
    end

    context "has an exit station but no entry station" do
      before do
        subject.exit_station = station
      end
      
      it "should return the penalty fare" do
        expect(subject.fare).to eq described_class::PENALTY_FARE
      end
    end

  end
end
