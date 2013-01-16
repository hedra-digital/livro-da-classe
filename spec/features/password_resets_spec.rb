# encoding: utf-8

require 'spec_helper'

describe "PasswordResets" do
  context "when requesting password reset" do
    it "emails valid user" do
      user = create(:user)
      visit signin_path
      click_link "Esqueceu"
      fill_in "Email", :with => user.email
      click_button 'Enviar'
      current_path.should eq(root_path)
      page.should have_content("Email enviado")
      last_email.to.should include(user.email)
    end

    it "does not email invalid user" do
      visit signin_path
      click_link "Esqueceu"
      fill_in "Email", :with => "nobody@example.com"
      click_button 'Enviar'
      current_path.should eq(root_path)
      page.should have_content("Email enviado")
      last_email.should be_nil
    end
  end

  context "when confirmation matches" do
    it "updates the user password" do
      user = create(:user, :password_reset_token => "something", :password_reset_sent_at => 1.hour.ago)
      visit edit_password_reset_path(user.password_reset_token)
      fill_in "Senha", :with => "password"
      click_button "Alterar senha"
      page.should have_content("não está de acordo com a confirmação")
      fill_in "Senha", :with => "password"
      fill_in "Confirmação da senha", :with => "password"
      click_button "Alterar senha"
      save_and_open_page
      page.should have_content("A senha foi alterada")
    end
  end
end
