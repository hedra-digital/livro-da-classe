# encoding: utf-8
# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
#  email                  :string(255)
#  password_digest        :string(255)
#  educator               :boolean
#  student_count          :integer
#  school_name            :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#  provider               :string(255)
#  uid                    :string(255)
#


require 'spec_helper'

describe User do
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }

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
      user1 = create(:user, :email => 'foo@bar.com')
      user2 = build(:user, :email => 'foo@bar.com')
      user2.should_not be_valid
      user2.should have(1).error_on(:email)
    end

    it 'is invalid if email has a weird format' do
      user = build(:user, :email => 'dada')
      user.should_not be_valid
      user.should have(1).error_on(:email)
    end
  end

  context 'when creating a new user' do
    let(:user) { create(:user) }

    it 'has an authentication token' do
      user.auth_token.should_not be_nil
    end
  end

  describe "#send_password_reset" do
    let(:user) { create(:user) }

    it "generates a unique password_reset_token each time" do
      user.send_password_reset
      last_token = user.password_reset_token
      user.send_password_reset
      user.password_reset_token.should_not eq(last_token)
    end

    it "saves the time the password reset was sent" do
      user.send_password_reset
      user.reload.password_reset_sent_at.should be_present
    end

    it "delivers mail to user" do
      user.send_password_reset
      last_email.to.should include(user.email)
    end
  end
end
