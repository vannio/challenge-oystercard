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

		it 'topup should raise error if balance would be over limit' do
			max_balance = Oystercard::MAX_BALANCE
			expect{oystercard.topup(100)}.to raise_error "Balance exceeded limit of #{max_balance}"
		end

	end

	context '#deduct' do

		it '#deduct should reduce balance by 1' do
			oystercard.topup(20)
			oystercard.deduct
			expect(oystercard.balance).to eq(19)
		end

	end

end
