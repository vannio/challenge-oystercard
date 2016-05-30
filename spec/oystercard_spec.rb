require "oystercard"

describe Oystercard do
  it "has an initial balance of 0" do
    expect(subject.balance).to eq(0)
  end

  describe "#top_up" do
    it "is topped up by a specified amount" do
      expect { subject.top_up(1000) }.to change { subject.balance }.by(1000)
    end

    it "does not allow topping up beyond the maximum balance limit" do
      expect do
        subject.top_up(described_class::MAXIMUM_BALANCE + 1)
      end.to raise_error(described_class::ERROR[:exceed_limit])
    end
  end

  describe "#deduct_fare" do
    it "deducts a fare from the balance" do
      subject.top_up(1000)
      expect { subject.deduct_fare(200) }.to change { subject.balance }.by(-200)
    end
  end
end
