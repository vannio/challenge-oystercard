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
			it "raises an error if card balance is less than  £#{Oystercard::MIN_LIMIT}" do
				expect {subject.touch_in(station)}.to raise_error "Can't touch in your balance is below £#{Oystercard::MIN_LIMIT}"
			end

			context "has topped up" do
				before do
					subject.top_up(5)
					subject.touch_in(station)
				end
			end
		end

		describe '#touch_out(station)' do
			before do
				subject.top_up(5)
				subject.touch_in(station)
			end

			context "has touched out" do
				before do
					subject.touch_out(station)
				end

				it "reduces the card balance by the journey fare #{Oystercard::FARE}" do
					expect{subject.touch_out(station)}.to change{subject.balance}.by "-#{Oystercard::FARE}".to_i
				end
			end
		end

		describe "#previous_journeys" do
			it "should respond to #each" do
				expect(subject.previous_journeys).to respond_to(:each)
			end

			it "has an empty list by default" do
				expect(subject.previous_journeys).to be_empty
			end

			it "touch_out updates the previous_journeys array" do
				expect { subject.touch_out(station) }.to change { subject.previous_journeys }
			end
		end

	end
end
