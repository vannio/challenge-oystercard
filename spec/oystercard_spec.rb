require 'oystercard'

describe Oystercard do 
	
	subject(:oystercard) { described_class.new }

	context '#balance' do

		it 'should eq zero by default' do
			expect(oystercard.balance).to eq 0
		end

	end

	context '#topup' do

		it 'should respond to #topup with 1 argument' do
			expect(oystercard).to respond_to(:topup).with(1).argument
		end 

		it 'topup(value) should increase #balance by value' do
			oystercard.topup(20)
			expect(oystercard.balance).to eq(20)
		end

	end

end