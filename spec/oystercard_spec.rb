require 'oystercard'

describe Oystercard do

	subject(:oystercard) { described_class.new }

	let(:station) { double :station }
	let(:exit_station) { double :exit_station }

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

	context '#in_journey' do

		it { is_expected.to respond_to(:in_journey?)}

		it '#in_journey = false on initialization' do
			expect(oystercard.in_journey?).to eq(false)
		end

		it 'in_journey? true if entry_station exists' do
			oystercard.topup(10)
			oystercard.touch_in(station)
			expect(oystercard.in_journey?).to eq(true)
		end

	end

	context '#touch_in' do

		it { is_expected.to respond_to(:touch_in).with(1).argument }

		it 'expects the card to save the entry station' do
			oystercard.topup(10)
			oystercard.touch_in(station)
			expect(oystercard.entry_station).to eq(station)
		end

		it 'allows user to touch in' do
			oystercard.topup(10)
			oystercard.touch_in(station)
			expect(oystercard.in_journey?).to eq(true)
		end

		it 'fails if balance is below MIN_FARE' do
			expect{oystercard.touch_in(station)}.to raise_error "insufficient balance"
		end

	end


	context '#touch_out' do

		it { is_expected.to respond_to(:touch_out).with(1).argument }

		it 'expects the card to save the exit station' do
			oystercard.topup(10)
			oystercard.touch_in(station)
			oystercard.touch_out(exit_station)
			expect(oystercard.exit_station).to eq(exit_station)
		end

		it 'allows user to touch out' do
			oystercard.topup(10)
			oystercard.touch_in(station)
			oystercard.touch_out(exit_station)
			expect(oystercard.in_journey?).to eq(false)
		end

		it 'charges the minimum fare' do
			oystercard.topup(5)
			oystercard.touch_in(station)
			expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-Oystercard::MIN_FARE)
		end

	end

end
