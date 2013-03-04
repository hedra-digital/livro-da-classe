# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :text
#  text_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Comment do
  it { should respond_to(:content) }
  it { should respond_to(:user_id) }
  it { should respond_to(:text_id) }

  it { should respond_to(:text) }
  it { should respond_to(:user) }

  context 'when validating' do
    it 'should be invalid without content' do
      comment = build(:comment, :content => nil)
      comment.should_not be_valid
      comment.should have(1).error_on(:content)
    end

    it 'should be invalid without user_id' do
      comment = build(:comment, :user_id => nil)
      comment.should_not be_valid
      comment.should have(1).error_on(:user_id)
    end 

    it 'should be invalid without text_id' do
      comment = build(:comment, :text_id => nil)
      comment.should_not be_valid
      comment.should have(1).error_on(:text_id)
    end
  end
end
