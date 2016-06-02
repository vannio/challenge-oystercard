require 'station'

describe Station do

	subject{described_class.new('Holborn', 1)}

	it 'knows its own name' do
		expect(subject.name).to_not be_nil
	end

	it 'knows its own zone' do
		expect(subject.zone).to be_integer
		
	end
end
