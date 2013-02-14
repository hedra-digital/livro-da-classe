require 'spec_helper'

describe Collaboration do
  it { should respond_to(:book_id) }
  it { should respond_to(:collaborator_id) }
end
