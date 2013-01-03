require 'spec_helper'

describe 'user flow' do

  it 'visits the home page' do
    visit root_path
    expect(first('head title').native.text).to eq "Livro da Classe"
  end

  it 'clicks the sign up button'

  it 'fills up form'

end
