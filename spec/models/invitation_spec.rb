require 'spec_helper'

describe Invitation do
  it { should respond_to(:invited_id) }
  it { should respond_to(:book_id) }
end
