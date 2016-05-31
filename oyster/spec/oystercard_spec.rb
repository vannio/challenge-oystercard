require 'oystercard'

describe Oystercard do
# In order to use public transport
# As a customer
# I want money on my card
describe '#balance' do

	it { is_expected.to respond_to(:balance) }

	it 'has an initial balance of 0' do
		expect(subject.balance).to eq 0
	end


describe "#top_up" do

  it { is_expected.to respond_to(:top_up).with(1).argument }

  it "should increase the balance" do
    bal = subject.balance
    expect(subject.top_up(5)).to be == bal + 5
  end


end

end
end