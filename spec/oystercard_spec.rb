require 'oystercard'

describe Oystercard do
	let ( :station ) { double(:station) }
	describe '#balance' do

		it { is_expected.to respond_to(:balance) }

		it 'has an initial balance of 0' do
			expect(subject.balance).to eq 0
		end

		describe "#top_up" do

			it { is_expected.to respond_to(:top_up).with(1).argument }

			it "should increase the balance" do
				expect{subject.top_up(5)}.to change{subject.balance}.by 5
			end

			it "raises an error if top_up amount would push balance over #{Oystercard::BALANCE_LIMIT}" do
				expect { subject.top_up(91) }.to raise_error "Can't add to your balance; would breach the £#{Oystercard::BALANCE_LIMIT} limit"
			end
		end 

		describe '#touch_in(station)' do
			it "should indicate that user has touched in and begins journey" do
				subject.top_up(5)
				subject.touch_in(station)
				expect(subject).to be_in_journey 
			end

			it "raises an error if card balance is less than  £#{Oystercard::MIN_LIMIT}" do
				expect {subject.touch_in(station)}.to raise_error "Can't touch in your balance is below £#{Oystercard::MIN_LIMIT}"
			end

			it 'stores the name of a journey\'s entry station' do
				subject.top_up(5)
				subject.touch_in(station)
				expect(subject.entry_station).to eq station
			end
		end

		describe '#touch_out' do
			it 'should indicate that the user has touched out and ends journey' do
				subject.top_up(5)
				subject.touch_in(station)
				subject.touch_out
				expect(subject).not_to be_in_journey
			end

			it "reduces the card balance by the journey fare #{Oystercard::FARE}" do
				subject.top_up(5)
				subject.touch_in(station)
				subject.touch_out
				expect{subject.touch_out}.to change{subject.balance}.by "-#{Oystercard::FARE}".to_i
			end	

			it 'sets the entry_station to nil on touch_out' do
				subject.top_up(5)
				subject.touch_in(station)
				expect{subject.touch_out}.to change{subject.entry_station}.to nil
			end

		end

		# describe '#entry_station'
		# 	it 'allows a card to "know" & store entry_station
		# end
	end 
end