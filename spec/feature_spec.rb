require "oystercard"
require "station"

describe "Feature Test" do
  let(:zone_1_station) { instance_double(Station, name: "Zone One", zone: 1) }
  let(:zone_2_station) { instance_double(Station, name: "Zone Two", zone: 2) }
  let(:zone_6_station) { instance_double(Station, name: "Zone Six", zone: 6) }

  subject(:oystercard) { Oystercard.new }

  context "is topped up and has started a journey" do
    before do
      oystercard.topup(20)
      oystercard.touch_in(zone_1_station)
    end

    it "takes a few complete journeys" do
  		oystercard.touch_out(zone_6_station)
      oystercard.touch_in(zone_6_station)
  		oystercard.touch_out(zone_2_station)
      expect(oystercard.balance).to eq(9)
  	end

    it "takes an incomplete journey" do
      oystercard.touch_in(zone_2_station)
  		oystercard.touch_out(zone_1_station)
      expect(oystercard.balance).to eq(12)
  	end
  end
end
