require "oystercard"

describe "Feature test" do
	it "feature tests" do
		oystercard = Oystercard.new
		oystercard.balance
		oystercard.topup(20)
		#oystercard.deduct(1)
		oystercard.in_journey?
		oystercard.touch_in(:station)
		oystercard.touch_out(:station)


	end
end
