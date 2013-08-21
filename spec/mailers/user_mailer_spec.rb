# encoding: utf-8

require "spec_helper"

describe UserMailer do
  describe "password_reset" do
    let(:user) { create(:user, :password_reset_token => "anything") }
    let(:mail) { UserMailer.password_reset(user) }

    it "sends user password reset url" do
      mail.subject.should eq("Recuperação de senha")
      mail.to.should eq([user.email])
      mail.from.should eq(["nao-responda@livrodaclasse.com.br"])
      mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
    end
  end

end
