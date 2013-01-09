require 'spec_helper'

describe School do

  it { should respond_to(:name) }

  it { should respond_to(:state) }

  it { should respond_to(:city) }

  context 'when validating' do

    it 'is invalid without a name' do
      school = build(:school, :name => nil)
      school.should_not be_valid
      expect { school.save! }.to raise_error(
        ActiveRecord::RecordInvalid
      )
      school.should have(1).error_on(:name)
    end

    it 'is invalid without a state' do
      school = build(:school, :state => nil)
      school.should_not be_valid
      expect { school.save! }.to raise_error(
        ActiveRecord::RecordInvalid
      )
      school.should have(1).error_on(:state)
    end

    it 'is invalid without a city' do
      school = build(:school, :city => nil)
      school.should_not be_valid
      expect { school.save! }.to raise_error(
        ActiveRecord::RecordInvalid
      )
      school.should have(1).error_on(:city)
    end

  end

end
