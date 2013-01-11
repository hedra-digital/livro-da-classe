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
      fill_in 'user_name', :with => 'John'
      fill_in 'user_email', :with => 'john@example.com'
      fill_in 'user_password', :with => 'password'
      fill_in 'user_password_confirmation', :with => 'password'
      check 'user_teacher'
      fill_in 'user_student_count', :with => '50'
      fill_in 'user_school_name', :with => 'EEPSG Aluísio Nunes'
      click_button 'Criar Usuário'
    end

    it 'types matching passwords' do
      visit new_user_path
      fill_in 'user_name', :with => 'John'
      fill_in 'user_email', :with => 'john@example.com'
      fill_in 'user_password', :with => 'password'
      fill_in 'user_password_confirmation', :with => 'dada'
      check 'user_teacher'
      fill_in 'user_student_count', :with => '50'
      fill_in 'user_school_name', :with => 'EEPSG Aluísio Nunes'
      click_button 'Criar Usuário'
      page.should have_content('não está de acordo com a confirmação')
    end

    it 'sees his user ID on the page' do
      visit new_user_path
      fill_in 'user_name', :with => 'John'
      fill_in 'user_email', :with => 'john@example.com'
      fill_in 'user_password', :with => 'password'
      fill_in 'user_password_confirmation', :with => 'password'
      check 'user_teacher'
      fill_in 'user_student_count', :with => '50'
      fill_in 'user_school_name', :with => 'EEPSG Aluísio Nunes'
      click_button 'Criar Usuário'
      page.should have_content('john@example.com')
    end

  end

end
