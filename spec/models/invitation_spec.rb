# == Schema Information
#
# Table name: invitations
#
#  id         :integer          not null, primary key
#  invited_id :integer
#  book_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Invitation do
  it { should respond_to(:invited_id) }
  it { should respond_to(:book_id) }
end
