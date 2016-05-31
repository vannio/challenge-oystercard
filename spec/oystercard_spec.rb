require "oystercard"

describe Oystercard do
  subject(:oystercard) { described_class.new }

  let(:station) { double(:station) }

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

  describe "#touch_in" do
    before do
      oystercard.top_up(Oystercard::MINIMUM_FARE)
    end

    it "begins the journey" do
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to_not be nil
    end

    context "low balance" do
      subject(:oystercard_low_balance) { described_class.new }

      it "throws an error if balance is too low" do
        expect { oystercard_low_balance.touch_in }.to raise_error
      end
    end
  end

  describe "#touch_out" do
    before do
      oystercard.top_up(10)
      oystercard.touch_in(station)
    end

    it "ends the journey" do
      oystercard.touch_out
      expect(oystercard.entry_station).to be nil
    end

    it "deducts the minimum fare" do
      expect { oystercard.touch_out }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
    end

    it "forgets the entry station" do
      oystercard.touch_out
      expect(oystercard.entry_station).to be nil
    end
  end

  describe "#entry_station" do
    before do
      oystercard.top_up(10)
      oystercard.touch_in(station)
    end

    it "records entry station" do
      expect(oystercard.entry_station).to eq station
    end
  end
end
