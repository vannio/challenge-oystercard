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

		it 'should respond to #deduct with 1 argument' do
			expect(oystercard).to respond_to(:topup).with(1).argument
		end

		it '#deduct should reduce balance by 1' do
			oystercard.topup(20)
			oystercard.deduct(1)
			expect(oystercard.balance).to eq(19)
		end

	end

	context '#in_journey' do

		it { is_expected.to respond_to(:in_journey?)}

		it '#in_journey = false on initialization' do
			expect(oystercard.in_journey?).to eq(false)
		end
	end

	context '#touch_in' do

		it 'allows user to touch in' do
			oystercard.touch_in
			expect(oystercard.in_journey?).to eq(true)
		end

	end


	context '#touch_out' do

		it 'allows user to touch out' do
			oystercard.touch_in
			oystercard.touch_out
			expect(oystercard.in_journey?).to eq(false)
		end

	end



end
