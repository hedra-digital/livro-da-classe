# encoding: utf-8

require 'spec_helper'

describe User do

  it { should respond_to(:name) }

  it { should respond_to(:email) }

  it { should respond_to(:password_digest) }

  it { should respond_to(:teacher) }

  it { should respond_to(:student_count) }

  it { should respond_to(:school_name) }

  context 'when validating' do

    it 'is invalid without a name' do
      user = build(:user, :name => nil)
      user.should_not be_valid
      user.should have(1).error_on(:name)
    end

    it 'is invalid without an email' do
      user = build(:user, :email => nil)
      user.should_not be_valid
      user.should have(1).error_on(:email)
    end

    it 'is invalid without a password' do
      user = build(:user, :password_digest => nil)
      user.should_not be_valid
      user.should have(1).error_on(:password_digest)
    end

    it 'is invalid if email is taken' do
      user = User.create(name: 'José Manoel', email: 'name@example.com', password: 'password')
      user2 = User.create(name: 'José Manoel', email: 'name@example.com', password: 'password')
      user2.should_not be_valid
      user2.should have(1).error_on(:email)
    end

    it 'is invalid if email has a weird format' do
      user = build(:user, :email => 'dada')
      user.should_not be_valid
      user.should have(1).error_on(:email)
    end

  end

end
