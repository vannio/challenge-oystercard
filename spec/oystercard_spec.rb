require "oystercard"

describe Oystercard do
  subject(:oystercard) { described_class.new }

  let(:entry_station) { double :station, :zone => 3 }
  let(:exit_station) { double :exit_station, :zone => 3 }
  let(:journey) { double :journey }

  describe "#balance" do
    it "should eq zero by default" do
      expect(oystercard.balance).to eq(0)
    end
  end

  describe "#topup" do
    it "topup(value) should increase #balance by value" do
      oystercard.topup(20)
      expect(oystercard.balance).to eq(20)
    end

    it "topup should raise error if balance would be over limit" do
      max_balance = described_class::MAX_BALANCE
      expect{oystercard.topup(100)}.to raise_error("Balance exceeded limit of #{ max_balance }")
    end
  end

  describe "#touch_in" do
    it "fails if balance is below MIN_FARE" do
      expect { oystercard.touch_in(entry_station) }.to raise_error("Insufficient balance")
    end

    it "charges penalty fare when incomplete journey (no finish)" do
      oystercard.topup(10)
      oystercard.touch_in(entry_station)
      expect { oystercard.touch_in(entry_station) }.to change { oystercard.balance }.by(-Journey::PENALTY_FARE)
    end
  end
  describe "#touch_out" do
    it "charges min fair for a single-zone journey" do
      oystercard.topup(10)
      oystercard.touch_in(entry_station)
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by(-Oystercard::MIN_FARE)
    end

    it "charges PENALTY_FARE for incomplete journey (no entry)" do
      oystercard.topup(10)
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by(-Journey::PENALTY_FARE)
    end
  end
end
