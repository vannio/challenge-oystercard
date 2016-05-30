require "Oystercard"

describe Oystercard do
  it "starts with balance of 0" do
    expect(subject.balance).to eq(0)
  end

  it "it responds to top_up with argument" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  describe "#top_up" do
    it "adds to the balance" do
      expect{subject.top_up(1)}.to change{subject.balance}.by(1)
    end
  end
end