require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  let(:station) { double :station, :zone => 3 }
  let(:exit_station) { double :exit_station, :zone => 3 }
  let(:journey) {double :journey}

  # it 'has an empty list of arrays by default' do
  #   expect(oystercard.journeys).to be_empty
  # end

  describe '#balance' do

    it 'should eq zero by default' do
      expect(oystercard.balance).to eq 0
    end
  end
  describe '#topup' do

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
  describe '#touch_in' do

    it { is_expected.to respond_to(:touch_in).with(1).argument }

    it 'fails if balance is below MIN_FARE' do
      expect{oystercard.touch_in(station)}.to raise_error "insufficient balance"
    end

    it 'charges penalty fare when incomplete journey (no finish)' do
      oystercard.topup(10)
      oystercard.touch_in(station)
      expect{ oystercard.touch_in(station) }.to change{ oystercard.balance }.by (-Journey::PENALTY_FARE)
    end
  end
  describe '#touch_out' do

    it 'charges min fair for a single-zone journey' do
      oystercard.topup(10)
      oystercard.touch_in(station)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by (-Oystercard::MIN_FARE)
    end

    it 'charges PENALTY_FARE for incomplete journey (no entry)' do
      oystercard.topup(10)
      expect{oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by (-Journey::PENALTY_FARE)
    end
  end
end
