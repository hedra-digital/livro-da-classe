# encoding: utf-8

require 'spec_helper'

describe 'unregistered user' do

  context 'when creating a new account' do

    it 'visits the home page' do
      visit root_path
      page.should have_selector('h1', :text => 'Livro da Classe')
      page.should have_link('signup', :href => new_user_path)
    end

    it 'clicks the sign up button' do
      visit root_path
      click_link('signup')
      page.should have_selector('h1', :text => 'Cadastre a sua escola', :visible => true)
      current_path.should == '/cadastro'
    end

    it 'fills up form' do
      visit new_user_path
      fill_in 'Nome', :with => 'John'
      fill_in 'E-mail', :with => 'john@example.com'
      fill_in 'Senha', :with => 'password'
      fill_in 'Confirmação da senha', :with => 'password'
      click_button 'Criar Usuário'
    end

  end

end
