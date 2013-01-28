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
      let(:user) { build(:user, :student_count => 50, :school_name => 'EEPSG Aluísio Nunes') }

      before do
        visit new_user_path
        fill_in 'user_name', :with => user.name
        fill_in 'user_email', :with => user.email
        fill_in 'user_password', :with => user.password
        fill_in 'user_password_confirmation', :with => user.password
        check 'user_educator'
        fill_in 'user_student_count', :with => user.student_count
        fill_in 'user_school_name', :with => user.school_name
      end

      it 'fills in all fields and clicks button' do
        click_button 'Criar Usuário'
      end

      it "sees error if passwords dont't match" do
        fill_in 'user_password_confirmation', :with => 'dada'
        click_button 'Criar Usuário'
        page.should have_content('não está de acordo com a confirmação')
      end

      it 'sees his user ID on successful sign up' do
        click_button 'Criar Usuário'
        page.should have_content(user.name)
      end
    end

    context 'when signing up successfully through twitter' do
      before do
        visit root_path
        click_link('signup')
      end

      it 'clicks the twitter link' do
        page.should have_link('Twitter')
        click_link('Twitter')
      end

      it 'shows signed in info on the page' do
        page.should have_link('Twitter')
        click_link('Twitter')
        page.should have_content(OmniAuth.config.mock_auth[:twitter][:info][:name])
      end
    end
   end
end

describe 'registered user' do
  let(:user) { create(:user, :password => 'anything') }

  context 'when signing in' do
    before do
      visit root_path
      click_link('Entrar no site')
      fill_in 'signin_email', :with => user.email
      fill_in 'signin_password', :with => 'anything'
      click_button 'Entrar'
    end

    it 'fills in sign in form' do
      current_path.should == app_home_path
    end

    context 'when editing his/her profile' do
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
end

describe 'invalid registered user' do
  let(:user) { create(:user, :email => 'user@example.com', :password => 'anything') }

  it 'is invalid with wrong email' do
    visit root_path
    click_link('Entrar no site')
    fill_in 'signin_email', :with => 'dada'
    fill_in 'signin_password', :with => user.password
    click_button 'Entrar'
    current_path.should eq(sessions_path)
    page.should have_content('inválidos')
  end

  it 'is invalid with wrong password' do
    visit root_path
    click_link('Entrar no site')
    fill_in 'signin_email', :with => user.email
    fill_in 'signin_password', :with => 'dada'
    click_button 'Entrar'
    current_path.should eq(sessions_path)
    page.should have_content('inválidos')
  end

  it 'is invalid with wrong user and password' do
    visit root_path
    click_link('Entrar no site')
    fill_in 'signin_email', :with => 'dada'
    fill_in 'signin_password', :with => 'dada'
    click_button 'Entrar'
    current_path.should eq(sessions_path)
    page.should have_content('inválidos')
  end
end
