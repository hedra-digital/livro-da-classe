# == Schema Information
#
# Table name: clients
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  position   :string(255)
#  phone      :string(255)
#  company    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Client do
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:position) }
  it { should respond_to(:phone) }
  it { should respond_to(:company) }

  context 'when validating' do
    it 'is invalid without a user' do
      user = build(:client, :user_id => nil)
      user.should_not be_valid
      user.should have(1).error_on(:user_id)
    end
  end
end
