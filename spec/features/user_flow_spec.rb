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
      let(:user) { build(:user) }

      before do
        visit new_user_path
        fill_in 'user_name', :with => user.name
        fill_in 'user_email', :with => user.email
        fill_in 'user_password', :with => user.password
        fill_in 'user_password_confirmation', :with => user.password
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
        page.should have_content(user.email)
      end
    end

    context 'when signing up through Twitter' do
      before do
        visit root_path
        click_link('signup')
      end

      it 'clicks the Twitter link' do
        page.should have_link('Twitter')
        click_link('Twitter')
      end

      it 'shows signed in info on the page' do
        page.should have_link('Twitter')
        click_link('Twitter')
        page.should have_content(OmniAuth.config.mock_auth[:twitter][:info][:email])
      end
    end

    context 'when signing up through Facebook' do
      before do
        visit root_path
        click_link('signup')
      end

      it 'clicks the Facebook link' do
        page.should have_link('Facebook')
        click_link('Facebook')
      end

      it 'shows signed in info on the page' do
        page.should have_link('Facebook')
        click_link('Facebook')
        page.should have_content(OmniAuth.config.mock_auth[:facebook][:info][:email])
      end
    end

    context 'when signing up through Google' do
      before do
        visit root_path
        click_link('signup')
      end

      it 'clicks the Facebook link' do
        page.should have_link('Google')
        click_link('Google')
      end

      it 'shows signed in info on the page' do
        page.should have_link('Google')
        click_link('Google')
        page.should have_content(OmniAuth.config.mock_auth[:google][:info][:email])
      end
    end
   end
end

describe 'valid registered user' do
  let(:user) { create(:user, :password => 'anything') }

  context 'when signing in through email/password' do
    before do
      visit root_path
      click_link('Entrar no site')
    end

    it 'fills in sign in form' do
      fill_in 'signin_email', :with => user.email
      fill_in 'signin_password', :with => 'anything'
    end

    it 'clicks the sigin in button' do
      fill_in 'signin_email', :with => user.email
      fill_in 'signin_password', :with => 'anything'
      click_button 'Entrar'
      current_path.should eq(app_home_path)
    end
  end

  context 'when signing in through Twitter' do
    before do
      visit root_path
      click_link('Entrar no site')
    end

    it 'clicks on the Twitter link' do
      page.should have_link('Twitter')
      click_link('Twitter')
    end

    it 'shows signed in info on the page' do
      page.should have_link('Twitter')
      click_link('Twitter')
      page.should have_content(OmniAuth.config.mock_auth[:twitter][:info][:email])
    end
  end

  context 'when signing in through Twitter' do
    before do
      visit root_path
      click_link('Entrar no site')
    end

    it 'clicks on the Twitter link' do
      page.should have_link('Facebook')
      click_link('Facebook')
    end

    it 'shows signed in info on the page' do
      page.should have_link('Facebook')
      click_link('Facebook')
      page.should have_content(OmniAuth.config.mock_auth[:facebook][:info][:email])
    end
  end

  context 'when signing in through Google' do
    before do
      visit root_path
      click_link('Entrar no site')
    end

    it 'clicks on the Twitter link' do
      page.should have_link('Google')
      click_link('Google')
    end

    it 'shows signed in info on the page' do
      page.should have_link('Google')
      click_link('Google')
      page.should have_content(OmniAuth.config.mock_auth[:google][:info][:email])
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
      click_button 'Atualizar'
      page.should have_content('perfil foi alterado')
    end

    it 'edits password' do
      click_link('Perfil')
      click_link('Editar perfil')
      fill_in 'Senha', :with => 'newpass'
      fill_in 'Confirmação', :with => 'newpass'
      click_button 'Atualizar'
      page.should have_content('perfil foi alterado')
    end

    it "can't edit password with unmatching entries" do
      click_link('Perfil')
      click_link('Editar perfil')
      fill_in 'Senha', :with => 'newpass'
      fill_in 'Confirmação', :with => 'newfag'
      click_button 'Atualizar'
      page.should have_content('não está de acordo com a confirmação')
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
