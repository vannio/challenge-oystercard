require "Oystercard"

describe Oystercard do
  it "starts with balance of 0" do
    expect(subject.balance).to eq(0)
  end

  it "it responds to top_up with argument" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it "it responds to deduct with argument" do
    expect(subject).to respond_to(:deduct).with(1).argument
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

  describe "#deduct" do
    it "deducts from the balance" do
      expect{subject.deduct(1)}.to change{subject.balance}.by(-1)
    end
  end
end