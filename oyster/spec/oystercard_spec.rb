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
end
end