require 'spec_helper'

describe Project do
  it { should respond_to(:book_id) }
  it { should respond_to(:release_date) }
  it { should respond_to(:finish_date) }
end
