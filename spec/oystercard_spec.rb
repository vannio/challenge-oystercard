require "oystercard"

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe "#balance" do
    it "doesn't return nil" do
      expect(oystercard.balance).to_not be(nil)
    end
  end
end
