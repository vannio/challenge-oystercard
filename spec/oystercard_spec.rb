require "oystercard"

describe Oystercard do
  it "has an initial balance of 0" do
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it "is topped up by a specified amount" do
      expect { subject.top_up(1000) }.to change { subject.balance }.by(1000)
    end

    it "does not allow topping up beyond the maximum balance limit" do
      expect do
        subject.top_up(described_class::MAXIMUM_BALANCE + 1)
      end.to raise_error(described_class::ERROR[:exceed_limit])
    end
  end
end
