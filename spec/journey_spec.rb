require "journey"

describe Journey do
  let(:station) { double(:station) }

  it "should have no entry station on instantiation" do
    expect(subject.entry_station).to be_nil
  end

  it "should have no exit station on instantiation" do
    expect(subject.exit_station).to be_nil
  end

  it "should store a name of an entry station" do
    subject.entry_station = station
    expect(subject.entry_station).to eq station
  end

  it "should store a name of an exit station" do
    subject.exit_station = station
    expect(subject.exit_station).to eq station
  end

  describe "#in_journey?" do
    context "has neither entry nor exit stations" do
      it "should not be in journey" do
        expect(subject).to_not be_in_journey
      end
    end

    context "has an exit station" do
      before do
        subject.exit_station = station
      end

      it "should not be in journey" do
        expect(subject).to_not be_in_journey
      end
    end

    context "has an entry station but no exit station" do
      before do
        subject.entry_station = station
      end

      it "should be in journey" do
        expect(subject).to be_in_journey
      end
    end

    context "has both entry and exit station" do
      before do
        subject.entry_station = station
        subject.exit_station = station
      end

      it "should not be in journey" do
        expect(subject).to_not be_in_journey
      end
    end
  end

    # it "should indicate that user has touched in and begins journey" do
    #   expect(subject).to be_in_journey
    # end

    # it 'stores the name of a journey\'s entry station' do
    #   expect(subject.current_journey[:entry_station]).to eq station
    # end
    #
    # it 'sets the entry_station to nil on touch_out' do
    #   expect{subject.touch_out(station)}.to change{subject.current_journey[:entry_station]}.to nil
    # end
    #
    # it 'should indicate that the user has touched out and ends journey' do
    #   expect(subject).not_to be_in_journey
    # end
    #
    # it 'stores the name of a journey\'s exit station' do
    #   expect(subject.previous_journeys.last[:exit_station]).to eq station
    # end
    #
    # it "resets the current journey on touch out" do
    #   expect(subject.current_journey).to be_empty
    # end

end
