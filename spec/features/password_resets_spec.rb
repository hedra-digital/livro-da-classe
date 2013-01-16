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
end
