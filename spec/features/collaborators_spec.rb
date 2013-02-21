# encoding: utf-8

require 'spec_helper'

describe 'user with a book' do
  let(:organizer) { create(:organizer) }
  let(:book) { organizer.books.first }

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

    it 'fills up the collaborator email' do
      click_link 'Colaboradores'
      click_link 'Incluir novo'
      collaborator = create(:user)
      fill_in 'user_email', :with => collaborator.email
    end

    it 'clicks button to send the invitation' do
      click_link 'Colaboradores'
      click_link 'Incluir novo'
      collaborator = create(:user)
      fill_in 'user_email', :with => collaborator.email
      click_button 'Enviar convite'
      current_path.should eq(book_collaborators_path(book.uuid))
    end

    it 'emails valid user' do
      click_link 'Colaboradores'
      click_link 'Incluir novo'
      collaborator = create(:user)
      fill_in 'user_email', :with => collaborator.email
      click_button 'Enviar convite'
      current_path.should eq(book_collaborators_path(book.uuid))
      page.should have_content('Email enviado')
      last_email.to.should include(collaborator.email)
    end
  end

  context "when password token has expired" do
    it "shows a notice to user" do
      collaborator = create(:user, :books => [book], :password_reset_token => "something", :password_reset_sent_at => 5.hour.ago)
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      save_and_open_page
      fill_in "Nome", :with => collaborator.name
      fill_in "E-mail", :with => collaborator.email
      fill_in "Senha", :with => collaborator.password
      fill_in "Confirmação da senha", :with => collaborator.password
      click_button "Atualizar Usuário"
      page.should have_content("O link já expirou")
    end
  end
end
