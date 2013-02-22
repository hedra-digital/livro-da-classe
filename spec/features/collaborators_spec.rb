# encoding: utf-8

require 'spec_helper'

describe 'user who organizes a book' do
  let(:organizer) { create(:organizer) }
  let(:book) { organizer.organized_books.first }

  before do
    visit root_path
    click_link('Entrar no site')
    fill_in 'signin_email', :with => organizer.email
    fill_in 'signin_password', :with => organizer.password
    click_button 'Entrar'
    click_link 'Meus Livros'
    click_link book.title
  end

  context 'when inviting a collaborator' do
    it 'sees the book info' do
      page.should have_content(book.title)
      page.should have_xpath("//nav[@class='book-nav']")
    end

    it 'clicks the collaborators link' do
      click_link 'Colaboradores'
      current_path.should eq(book_collaborators_path(book.uuid))
    end

    it 'clicks the new collaborator button' do
      click_link 'Colaboradores'
      click_link 'Incluir novo'
      current_path.should eq(new_book_collaborator_path(book.uuid))
    end

    context 'when inviting a new user' do
      let(:email) { Faker::Internet.email }

      before do
        click_link 'Colaboradores'
        click_link 'Incluir novo'
        fill_in 'user_email', :with => email
      end

      it 'fills in the email' do
      end

      it 'clicks button to send the invitation' do
        click_button 'Enviar convite'
      end

      it 'creates user with the email typed' do
        click_button 'Enviar convite'
        User.where(:email => email).should_not be_nil
      end

      it 'is redirected to collaborators index' do
        click_button 'Enviar convite'
        current_path.should eq(book_collaborators_path(book.uuid))
      end

      it 'emails collaborator' do
        click_button 'Enviar convite'
        page.should have_content('Email enviado')
        User.where(:email => email).first.password_reset_token.should_not be_nil
        last_email.to.should include(email)
      end
    end

    context 'when inviting an invalid user' do
      let(:email) { 'foo' }

      before do
        click_link 'Colaboradores'
        click_link 'Incluir novo'
        fill_in 'user_email', :with => email
      end

      it 'fills in the email' do
      end

      it 'clicks button to send the invitation' do
        click_button 'Enviar convite'
      end

      it 'is not redirected' do
        click_button 'Enviar convite'
        current_path.should eq(new_book_collaborator_path(book.uuid))
      end

      it 'shows notice to user' do
        click_button 'Enviar convite'
        page.should have_content('O e-mail informado não é válido.')
      end

      it 'does not create user' do
        click_button 'Enviar convite'
        User.where(:email => email).first.should be_nil
      end

      it 'does not send email' do
        click_button 'Enviar convite'
        last_email.should be_nil
      end
    end

    context 'when inviting a registered user' do
      let(:collaborator) { create(:user) }

      before do
        click_link 'Colaboradores'
        click_link 'Incluir novo'
        fill_in 'user_email', :with => collaborator.email
      end

      it 'fills in the email of a registered user' do
      end

      it 'clicks button to send the invitation' do
        click_button 'Enviar convite'
        current_path.should eq(book_collaborators_path(book.uuid))
      end

      it 'emails collaborator' do
        click_button 'Enviar convite'
        page.should have_content('Email enviado')
        User.where(:email => collaborator.email).first.password_reset_token.should_not be_nil
        last_email.to.should include(collaborator.email)
      end

      it 'shows collaborator in index' do
        pending
      end
    end
  end
end

describe 'collaborator getting an invitation to a book' do
  let(:organizer) { create(:organizer) }
  let(:book) { organizer.organized_books.first }

  before do
    visit root_path
    click_link('Entrar no site')
    fill_in 'signin_email', :with => organizer.email
    fill_in 'signin_password', :with => organizer.password
    click_button 'Entrar'
    click_link 'Meus Livros'
    click_link book.title
    click_link 'Colaboradores'
    click_link 'Incluir novo'
  end

  context "when it is a new user" do
    # let(:collaborator) { build(:user, :password_reset_token => "something", :password_reset_sent_at => 1.hour.ago) }
    let(:email) { Faker::Internet.email }
    let(:name) { Faker::Name.name }
    let(:password) { Faker::Base.bothify('#?#?#?#?') }

    before do
      fill_in 'user_email', :with => email
      click_button 'Enviar convite'
    end

    it "visits the URL received by email" do
      # TODO: use actual URL from last_email.body
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      current_path.should eq(edit_book_collaborator_path(book.uuid, collaborator.password_reset_token))
    end

    it 'fills in personal info' do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => name
      fill_in "Senha", :with => password
      fill_in "Confirmação da senha", :with => password
      click_button "Atualizar Usuário"
    end

    it "is automatically logged in" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => name
      fill_in "Senha", :with => password
      fill_in "Confirmação da senha", :with => password
      click_button "Atualizar Usuário"
      page.should have_content(email)
      current_path.should eq(app_home_path)
    end

    it "gets added as collaborator to the book" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => name
      fill_in "Senha", :with => password
      fill_in "Confirmação da senha", :with => password
      expect{ click_button "Atualizar Usuário" }.to change { User.where(:password_reset_token => collaborator.password_reset_token).first.books.size }.by(1)
      User.where(:password_reset_token => collaborator.password_reset_token).first.books.should include(book)
    end
  end

  context "when it is a registered user" do
    pending

    context "who was not previously a collaborator in the book" do
      pending
    end

    context "who was previously a collaborator in the book" do
      pending
    end
  end

#   context "when password token has expired" do
#     let(:collaborator) { create(:user, :password_reset_token => "something", :password_reset_sent_at => 5.hours.ago) }

#     before do
#       visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
#       collab2 = build(:user)
#       fill_in "Nome", :with => collab2.name
#       fill_in "Senha", :with => collab2.password
#       fill_in "Confirmação da senha", :with => collab2.password
#     end

#     it "shows a notice to user" do
#       click_button "Atualizar Usuário"
#       page.should have_content("O link já expirou")
#     end

#     it "does not get added to the book" do
#       expect{ click_button "Atualizar Usuário" }.not_to change { User.where(:password_reset_token => "something").first.books }
#       User.where(:password_reset_token => "something").first.books.should_not include(book)
#     end
#   end
end
