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

    context 'when filling up sign up form' do
      before do
        visit new_user_path
        fill_in 'user_name', :with => 'John'
        fill_in 'user_email', :with => 'john@example.com'
        fill_in 'user_password', :with => 'password'
        fill_in 'user_password_confirmation', :with => 'password'
        check 'user_educator'
        fill_in 'user_student_count', :with => '50'
        fill_in 'user_school_name', :with => 'EEPSG Aluísio Nunes'
      end

      it 'fills in all fields' do
        click_button 'Criar Usuário'
      end

      it "sees error if passwords dont't match" do
        fill_in 'user_password_confirmation', :with => 'dada'
        click_button 'Criar Usuário'
        page.should have_content('não está de acordo com a confirmação')
      end

      it 'sees his user ID on successful sign up' do
        click_button 'Criar Usuário'
        # save_and_open_page
        page.should have_content('john@example.com')
      end
    end
  end
end

describe 'signed out user' do
  context 'when signing in' do
    let(:user) { create(:user, :password => "password") }

    it 'clicks the sign in link' do
      visit root_path
      click_link('Entrar')
      page.should have_content('Entrar no site')
    end

    it 'fills up sign in form' do
      visit root_path
      click_link('Entrar')
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Entrar'
      page.should have_content('autenticado')
    end
  end
end
