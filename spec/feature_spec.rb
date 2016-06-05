require "oystercard"
require "station"

describe "Feature test" do
  let(:zone_1_station) { instance_double(Station, name: "Zone One", zone: 1) }
  let(:zone_2_station) { instance_double(Station, name: "Zone Two", zone: 2) }
  let(:zone_6_station) { instance_double(Station, name: "Zone Six", zone: 6) }

  subject(:oystercard) { Oystercard.new }

  it "tops up then takes a few journeys" do
		oystercard.topup(20)
    oystercard.touch_in(zone_1_station)
		oystercard.touch_out(zone_6_station)
    oystercard.touch_in(zone_6_station)
		oystercard.touch_out(zone_2_station)
    expect(oystercard.balance).to eq(9)
	end

  it "tops up then takes an incomplete journey" do
		oystercard.topup(20)
    oystercard.touch_in(zone_1_station)
    oystercard.touch_in(zone_2_station)
		oystercard.touch_out(zone_1_station)
    expect(oystercard.balance).to eq(12)
	end
end
