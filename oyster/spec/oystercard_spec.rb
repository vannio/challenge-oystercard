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

		it 'raises an error if top_up amount would push balance over 90' do
		expect { subject.top_up(91) }.to raise_error "Can't add to your balance; would breach the £90 limit"
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
		# it 'raises an error if not currently traveling' do
		# expect { subject.top_up(91) }.to raise_error "Can't add to your balance; would breach the £90 limit"
		# end
				
		# it 'necessarilly has a starting value of false; not in-transit' do 
		# expect(subject.in_journey?).to eq false
		# end

	
		# it 'has a value of true after being used to \'touch in\', but not yet to \'touch out' do
	
		# 	expect(subject.in_journey).to eq true
	
		# end
	end

	describe '#touch_in' do
		it 'should indicate that user has touched in and begins journey' do
		expect(subject.touch_in).to eq true 
		end
		end

		describe '#touch_out' do
		it 'should indicate that the user has touched out and ends journey' do
		expect(subject.touch_out).to eq false
		end
	end
	end 
end