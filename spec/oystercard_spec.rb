require "oystercard"

describe Oystercard do
  subject(:oystercard) { described_class.new }

  describe "#balance" do
    it "doesn't return nil" do
      expect(oystercard.balance).to_not be(nil)
    end
  end

  describe "#top_up" do
    it "takes a number" do
      expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
    end

    it "won't accept a topup over the limit" do
      max = Oystercard::MAXIMUM_LIMIT
      expect { oystercard.top_up(max + 1) }.to raise_error
    end
  end

  describe "#deduct" do
    it "deducts an amount" do
      expect { oystercard.deduct(10) }.to change { oystercard.balance }.by(-10)
    end
  end

  describe "#touch_in" do
    before do
      oystercard.top_up(Oystercard::MINIMUM_LIMIT)  
    end

    it "begins the journey" do
      oystercard.touch_in
      expect(oystercard).to be_in_journey
    end

    context "low balance" do
      subject(:oystercard_low_balance) { described_class.new }

      it "throws an error if balance is too low" do
        expect { oystercard_low_balance.touch_in }.to raise_error
      end
    end
  end

  describe "#touch_out" do
    it "ends the journey" do
      oystercard.touch_out
      expect(oystercard).to_not be_in_journey
    end
  end
end
