# encoding: utf-8

require 'spec_helper'

describe "Sessions" do
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
      page.should have_content(user.email)
    end

    it 'clicks the sign out link' do
      visit root_path
      click_link('Entrar')
      fill_in 'Email', :with => user.email
      fill_in 'Password', :with => user.password
      click_button 'Entrar'
      click_link('Sair')
      page.should have_content('saiu da área logada')
    end

    # context "when remembering user" do
    #   it "stores a permanent cookie" do
    #     visit root_path
    #     click_link('Entrar')
    #     fill_in 'Email', :with => user.email
    #     fill_in 'Password', :with => user.password
    #     check 'signin_remember_me'
    #     click_button 'Entrar'
    #     page.driver.cookies.permanent[:auth_token].should eq(user.auth_token)
    #   end
    # end

    # context "when not remembering user" do
    #   it "stores a non-permanent cookie" do
    #     visit root_path
    #     click_link('Entrar')
    #     fill_in 'Email', :with => user.email
    #     fill_in 'Password', :with => user.password
    #     click_button 'Entrar'
    #     page.driver.cookies[:auth_token].should eq(user.auth_token)
    #     page.driver.cookies.permanent[:auth_token].should be_nil
    #   end
    # end
  end
end
