require "oystercard"

describe Oystercard do
  it "has an initial balance of 0" do
    expect(subject.balance).to eq(0)
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
    let(:station) { double(:station) }

    before(:each) do
      subject.top_up(described_class::MINIMUM_FARE)
    end

    describe "#touch_in" do
      it "should remember the entry station" do
        expect(subject.touch_in(station)).to eq subject.entry_station
      end
    end

    describe "#touch_out" do
      it "should deduct minimum fare from balance when journey ends" do
        expect do
          subject.touch_out
        end.to change { subject.balance }.by(- described_class::MINIMUM_FARE)
      end

      it "should forget the entry station" do
        subject.touch_in(station)
        expect do
          subject.touch_out
        end.to change { subject.entry_station }.to be_nil
      end
    end
  end

  context "has insufficient funds" do
    describe "#touch_in" do
      it "should not allow touching in when balance is too low" do
        expect do
          subject.touch_in
        end.to raise_error(described_class::ERROR[:insufficient_funds])
      end
    end
  end

  describe "#in_journey?" do
    before(:each) do
      subject.top_up(described_class::MINIMUM_FARE)
    end

    it "should not be in journey initially" do
      expect(subject).to_not be_in_journey
    end

    it "should be in journey after touching in" do
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "should not be in journey after touching out" do
      subject.touch_in
      subject.touch_out
      expect(subject).to_not be_in_journey
    end
  end
end
