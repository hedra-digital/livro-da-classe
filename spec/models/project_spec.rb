# == Schema Information
#
# Table name: projects
#
#  id           :integer          not null, primary key
#  book_id      :integer
#  release_date :date
#  finish_date  :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Project do
  it { should respond_to(:book_id) }
  it { should respond_to(:release_date) }
  it { should respond_to(:finish_date) }
end
