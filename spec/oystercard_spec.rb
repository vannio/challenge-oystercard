require "Oystercard"

describe Oystercard do

  context "when new card" do
    it "starts with balance of 0" do
      expect(subject.balance).to eq(0)
    end

    it "expected to not be in journey" do
      expect(subject).not_to be_in_journey
    end

    it "has no entry station set" do
      expect(subject.entry_station).to eq nil
    end
  end

  it "responds to top_up with argument" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  describe "#touch_in" do

    context "when card has sufficient balance" do

      let(:station){ double :station }
      it "can touch in" do
        subject.top_up(1)
        subject.touch_in(station)
        expect(subject).to be_in_journey
      end

      it "stores entry station" do
        subject.top_up(1)
        subject.touch_in(station)
        expect(subject.entry_station).to eq station
      end
    end

    context "when card has insufficient balance" do
      let(:station){ double :station }
      it "raises error if card balance below minimum fare value" do
        expect{ subject.touch_in(station) }.to raise_error "Error: minimum balance less than minimum fare. Top-up!"
      end
    end
  end

  describe "#touch_out" do
    let(:station){ double :station }
    it "can touch out" do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
    it "deducts min fare from balance on touch out" do
      expect{subject.touch_out}.to change{subject.balance}.by(-1)
    end

    it "forgets entry station" do
      subject.top_up(1)
      subject.touch_in(station)
      subject.touch_out
      expect(subject.entry_station).to eq nil
    end
  end

  describe "#top_up" do
    it "adds to the balance" do
      expect{subject.top_up(1)}.to change{subject.balance}.by(1)
    end
    it "doesnt allow to exceed max balance" do
      max_balance = Oystercard::MAX_BALANCE
      subject.top_up(max_balance)
      expect{subject.top_up(1)}.to raise_error "Maximum balance of #{max_balance} reached!"
    end
  end
end