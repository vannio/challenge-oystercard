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
			expect(subject.top_up(5)).to be == (bal + 5)
		end

		it 'raises an error if top_up amount would push balance over 90' do
			expect { subject.top_up(91) }.to raise_error "Can't add to your balance; would breach the £90 limit"
		end

	end

end
end