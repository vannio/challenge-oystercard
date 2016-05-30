require "oystercard"

describe Oystercard do
  it "has an initial balance of 0" do
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do
    it "is topped up by a specified amount" do
      expect { subject.top_up(10) }.to change { subject.balance }.by(10)
    end

    it "does not allow topping up beyond the maximum balance limit" do
      expect do
        subject.top_up(described_class::MAXIMUM_BALANCE + 1)
      end.to raise_error(described_class::ERROR[:exceed_limit])
    end
  end

  describe "#deduct_fare" do
    it "deducts a fare from the balance" do
      subject.top_up(10)
      expect { subject.deduct_fare(1) }.to change { subject.balance }.by(-1)
    end
  end

  describe "#touch_in" do
    it { is_expected.to respond_to(:touch_in) }

    it "should not allow touching in when balance is too low" do
      expect do
        subject.touch_in
      end.to raise_error(described_class::ERROR[:insufficient_funds])
    end
  end

  describe "#touch_out" do
    it { is_expected.to respond_to(:touch_out) }
  end

  describe "#in_journey?" do
    before(:each) do
      subject.top_up(1)
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
