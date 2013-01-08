require 'spec_helper'

describe 'unregistered user' do

  it 'visits the home page' do
    visit root_path
    expect(first('head title').native.text).to eq "Livro da Classe"
  end

  it { should have_link('Cadastre a sua escola', href: new_user_path) }

  # it 'shows the sign up button' do
  #   visit root_path
  #   click_link('signup')
  #   expect(first('h1').native.text).to eq "Cadastre a sua escola"
  # end

  it 'fills up form'

end
