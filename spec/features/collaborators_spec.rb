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

  context 'when inviting a new collaborator' do
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

    it 'fills in the collaborator email' do
      click_link 'Colaboradores'
      click_link 'Incluir novo'
      collaborator = build(:user)
      fill_in 'user_email', :with => collaborator.email
    end

    it 'clicks button to send the invitation' do
      click_link 'Colaboradores'
      click_link 'Incluir novo'
      collaborator = build(:user)
      fill_in 'user_email', :with => collaborator.email
      click_button 'Enviar convite'
      current_path.should eq(book_collaborators_path(book.uuid))
    end

    it 'emails collaborator' do
      click_link 'Colaboradores'
      click_link 'Incluir novo'
      collaborator = build(:user)
      fill_in 'user_email', :with => collaborator.email
      click_button 'Enviar convite'
      page.should have_content('Email enviado')
      User.where(:email => collaborator.email).first.password_reset_token.should_not be_nil
      last_email.to.should include(collaborator.email)
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
    collaborator = build(:user)
    fill_in 'user_email', :with => collaborator.email
    click_button 'Enviar convite'
    collaborator = User.where(:email => collaborator.email).first
  end

  context "when it is a new user" do
    it "creates a new account" do
      collaborator = User.where(:email => last_email.to).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      collab2 = build(:user)
      fill_in "Nome", :with => collab2.name
      fill_in "Senha", :with => collab2.password
      fill_in "Confirmação da senha", :with => collab2.password
      click_button "Atualizar Usuário"
      page.should have_content(collaborator.email)
      current_path.should eq(app_home_path)
    end
  end

  context "when password token has expired" do
    it "shows a notice to user" do
      collaborator = create(:user, :books => [book], :password_reset_token => "something", :password_reset_sent_at => 5.hour.ago)
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      collab2 = build(:user)
      fill_in "Nome", :with => collab2.name
      fill_in "Senha", :with => collab2.password
      fill_in "Confirmação da senha", :with => collab2.password
      click_button "Atualizar Usuário"
      page.should have_content("O link já expirou")
    end
  end
end
