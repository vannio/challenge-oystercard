require "Oystercard"

describe Oystercard do
  it "starts with balance of 0" do
    expect(subject.balance).to eq(0)
  end
end