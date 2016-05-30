require "oystercard"

describe Oystercard do
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe "#initialize" do
    it "has an initial balance of 0" do
      expect(subject.balance).to eq(0)
    end

    it "has an initial empty journey history" do
      expect(subject.journey_history).to be_empty
    end
  end

  describe "#top_up" do
    it "is topped up by a specified amount" do
      expect do
        subject.top_up(described_class::MINIMUM_FARE)
      end.to change { subject.balance }.by(described_class::MINIMUM_FARE)
    end

    it "does not allow topping up beyond the maximum balance limit" do
      expect do
        subject.top_up(described_class::MAXIMUM_BALANCE + 1)
      end.to raise_error(described_class::ERROR[:exceed_limit])
    end
  end

  context "has sufficient funds" do
    before(:each) do
      subject.top_up(described_class::MINIMUM_FARE)
    end

    describe "#touch_in" do
      it "should update journey history" do
        expect do
          subject.touch_in(entry_station)
        end.to change { subject.journey_history }
      end
    end

    context "is touched in" do
      before do
        subject.touch_in(entry_station)
      end

      describe "#touch_out" do
        it "should deduct minimum fare from balance when journey ends" do
          expect do
            subject.touch_out(exit_station)
          end.to change { subject.balance }.by(- described_class::MINIMUM_FARE)
        end
      end
    end

    describe "#in_journey?" do
      it "should not be in_journey initially" do
        expect(subject).to_not be_in_journey
      end

      it "should be in_journey after touching in" do
        subject.touch_in(entry_station)
        expect(subject).to be_in_journey
      end

      it "should not be in_journey after touching out" do
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject).to_not be_in_journey
      end
    end
  end

  context "has insufficient funds" do
    describe "#touch_in" do
      it "should not allow touching in when card has insufficient funds" do
        expect do
          subject.touch_in(entry_station)
        end.to raise_error(described_class::ERROR[:insufficient_funds])
      end
    end
  end
end
