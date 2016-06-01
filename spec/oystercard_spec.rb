require 'oystercard'

describe Oystercard do

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

		it 'raises an error if top_up amount would push balance over #{Oystercard::BALANCE_LIMIT} ' do
		expect { subject.top_up(91) }.to raise_error "Can't add to your balance; would breach the £#{Oystercard::BALANCE_LIMIT} limit"
		end
		end 

	describe '#deduct' do
		it { is_expected.to respond_to(:deduct).with(1).argument }
		it 'deducts a fare from an existing card balance' do 
				
		bal = subject.top_up(10)
		expect(subject.deduct(5)).to be == bal - 5
		end
		end

	describe '#in_journey?' do  
		it 'should not be start as in journey' do
		expect(subject.in_journey?).to eq false
		end
	end

	describe '#touch_in' do
		it 'should indicate that user has touched in and begins journey' do
		subject.top_up(2)
		subject.touch_in
		expect(subject).to be_in_journey 
		end
		it 'raises an error if card balance is less than £1' do
		expect {subject.touch_in}.to raise_error "Can't touch in your balance is below £1"
		end
	end

		describe '#touch_out' do
		it 'should indicate that the user has touched out and ends journey' do
		subject.top_up(2)
		subject.touch_in
		subject.touch_out
		expect(subject).not_to be_in_journey
		end
	end
	end 
end