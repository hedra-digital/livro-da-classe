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
        page.should have_content('john@example.com')
      end
    end

  #   context 'when signing up successfully through twitter' do
  #     before do
  #       visit root_path
  #       click_link('signup')
  #       page.should have_selector('h1', :text => 'Cadastre a sua escola', :visible => true)
  #       current_path.should == '/cadastro'
  #     end

  #     it 'clicks the twitter link' do
  #       page.should have_link('Twitter')
  #       click_link('Twitter')
  #     end

  #     it 'is redirected to twitter for authorization' do
  #       pending
  #     end

  #     it 'is redirected back to our website' do
  #       pending
  #     end

  #     it 'shows signed in info on the page' do
  #       pending
  #     end
  #   end
   end
end

describe 'registered user' do
  let(:user) { create(:user, :password => 'anything') }

  context 'when signing in' do
    it 'fills in sign in form' do
      visit root_path
      click_link('Entrar no site')
      fill_in 'signin_email', :with => user.email
      fill_in 'signin_password', :with => 'anything'
      click_button 'Entrar'
      current_path.should == app_home_path
    end
  end

  context 'when editing his/her profile' do
    before do
      visit root_path
      click_link('Entrar no site')
      fill_in 'signin_email', :with => user.email
      fill_in 'signin_password', :with => 'anything'
      click_button 'Entrar'
    end

    it 'views the user profile' do
      click_link('Perfil')
      current_path.should eq(user_path(user))
      page.should have_content(user.email)
    end

    it 'clicks the edit profile link' do
      click_link('Perfil')
      click_link('Editar perfil')
      current_path.should eq(edit_user_path(user))
    end

    it 'edits email' do
      click_link('Perfil')
      click_link('Editar perfil')
      fill_in 'E-mail', :with => 'different@example.com'
      click_button 'Gravar'
      page.should have_content('perfil foi alterado')
    end

    it 'edits password' do
      click_link('Perfil')
      click_link('Alterar senha')
      fill_in 'Senha', :with => 'newpass'
      fill_in 'Confirmação', :with => 'newpass'
      click_button 'Gravar'
      page.should have_content('perfil foi alterado')
    end

    # it 'is invalid with unmatching passwords' do
    #   click_link('Perfil')
    #   click_link('Alterar senha')
    #   fill_in 'Senha', :with => 'newpass'
    #   fill_in 'Confirmação', :with => 'newfag'
    #   click_button 'Gravar'
    #   page.should have_content('não está de acordo com a confirmação')
    # end
  end
end
