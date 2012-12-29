require 'spec_helper'

describe User do

  it 'is invalid without a name' do
    user = User.new(:email => 'test@example.com', :password_digest => 'test21')
    user.should_not be_valid
    expect { user.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it 'is invalid without an email' do
    user = User.new(:name => 'Joe Schmuck', :password_digest => 'test21')
    user.should_not be_valid
    expect { user.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

  it 'is invalid without a password' do
    user = User.new(:name => 'Joe Schmuck', :email => 'test@example.com')
    user.should_not be_valid
    expect { user.save! }.to raise_error(
      ActiveRecord::RecordInvalid
    )
  end

end
