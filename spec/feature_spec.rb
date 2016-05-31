require "oystercard"

describe "Feature test" do
	it "feature tests" do
		oystercard = Oystercard.new
		oystercard.balance
		oystercard.topup(20)
		oystercard.deduct
	end
end
