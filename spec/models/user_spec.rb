require 'spec_helper'

describe User do

  it { should respond_to(:name) }

  it { should respond_to(:email) }

  it { should respond_to(:password_digest) }

  context 'when validating' do

    it 'is invalid without a name' do
      user = build(:user, :name => nil)
      user.should_not be_valid
      expect { user.save! }.to raise_error(
        ActiveRecord::RecordInvalid
      )
      user.should have(1).error_on(:name)
    end

    it 'is invalid without an email' do
      user = build(:user, :email => nil)
      user.should_not be_valid
      expect { user.save! }.to raise_error(
        ActiveRecord::RecordInvalid
      )
      user.should have(1).error_on(:email)
    end

    it 'is invalid without a password' do
      user = build(:user, :password_digest => nil)
      user.should_not be_valid
      expect { user.save! }.to raise_error(
        ActiveRecord::RecordInvalid
      )
      user.should have(1).error_on(:password_digest)
    end

  end

end
