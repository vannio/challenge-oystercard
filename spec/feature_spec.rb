require 'oystercard'

describe Oystercard do

	subject(:oystercard) { described_class.new }

	context 'feature tests' do

		it 'initializes the card with a balance of zero' do
			expect(oystercard.balance).to eq 0 
		end

	end
end