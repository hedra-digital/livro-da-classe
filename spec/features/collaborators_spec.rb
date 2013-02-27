# encoding: utf-8

require 'spec_helper'

describe 'book organizer' do
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

    context 'who is a new user' do
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

      it 'is redirected to the collaborators index' do
        click_button 'Enviar convite'
        current_path.should eq(book_collaborators_path(book.uuid))
      end

      it 'emails collaborator' do
        click_button 'Enviar convite'
        page.should have_content('Email enviado')
        User.where(:email => email).first.password_reset_token.should_not be_nil
        last_email.to.should include(email)
      end

      it 'shows collaborator in index' do
        click_button 'Enviar convite'
        page.should have_content('Convites enviados')
        page.should have_content(email)
      end
    end

    context 'who is an invalid user' do
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

    context 'who is a registered user that is not a collaborator in the same book' do
      let(:collaborator) { create(:user) }

      before do
        click_link 'Colaboradores'
        click_link 'Incluir novo'
      end

      it 'fills in the email' do
        fill_in 'user_email', :with => collaborator.email
      end

      it 'clicks button to send the invitation' do
        fill_in 'user_email', :with => collaborator.email
        click_button 'Enviar convite'
      end

      it 'emails collaborator' do
        # binding.pry
        fill_in 'user_email', :with => collaborator.email
        click_button 'Enviar convite'
        page.should have_content('Email enviado')
        User.where(:email => collaborator.email).first.password_reset_token.should_not be_nil
        last_email.to.should include(collaborator.email)
      end

      it 'is redirected to the collaborators index' do
        fill_in 'user_email', :with => collaborator.email
        click_button 'Enviar convite'
        current_path.should eq(book_collaborators_path(book.uuid))
      end

      it 'shows collaborator in index' do
        fill_in 'user_email', :with => collaborator.email
        click_button 'Enviar convite'
        page.should have_content('Convites enviados')
        page.should have_content(collaborator.email)
      end
    end

    context 'who is a registered user that is already a collaborator in the same book' do
      let(:collaborator) { create(:user, :books => [book]) }

      before do
        click_link 'Colaboradores'
        click_link 'Incluir novo'
      end

      it 'fills in the email' do
        fill_in 'user_email', :with => collaborator.email
      end

      it 'clicks button to send the invitation' do
        fill_in 'user_email', :with => collaborator.email
        click_button 'Enviar convite'
      end

      it 'is not redirected' do
        fill_in 'user_email', :with => collaborator.email
        click_button 'Enviar convite'
        current_path.should eq(new_book_collaborator_path(book.uuid))
      end

      it 'shows notice to user' do
        fill_in 'user_email', :with => collaborator.email
        click_button 'Enviar convite'
        page.should have_content('O usuário informado já é colaborador do livro selecionado.')
      end

      it 'does not send email' do
        fill_in 'user_email', :with => collaborator.email
        click_button 'Enviar convite'
        last_email.should be_nil
      end
    end
  end
end

describe "user getting an invitation to a book" do
  context "when it is a new user with a valid token" do
    let(:organizer) { create(:organizer) }
    let(:book) { organizer.organized_books.first }
    let(:email) { Faker::Internet.email }
    let(:new_collaborator) { build(:user) }

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
      fill_in 'user_email', :with => email
      click_button 'Enviar convite'
    end

    it "visits the URL received by email" do
      # TODO: use actual URL from last_email.body
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      current_path.should eq(edit_book_collaborator_path(book.uuid, collaborator.password_reset_token))
    end

    it "fills in personal info" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => new_collaborator.name
      fill_in "Senha", :with => new_collaborator.password
      fill_in "Confirmação da senha", :with => new_collaborator.password
    end

    it "clicks button" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => new_collaborator.name
      fill_in "Senha", :with => new_collaborator.password
      fill_in "Confirmação da senha", :with => new_collaborator.password
      click_button "Atualizar Usuário"
    end

    it "is automatically logged in" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => new_collaborator.name
      fill_in "Senha", :with => new_collaborator.password
      fill_in "Confirmação da senha", :with => new_collaborator.password
      click_button "Atualizar Usuário"
      page.should have_content(collaborator.email)
      current_path.should eq(app_home_path)
    end

    it "gets added as collaborator to the book" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => new_collaborator.name
      fill_in "Senha", :with => new_collaborator.password
      fill_in "Confirmação da senha", :with => new_collaborator.password
      expect{ click_button "Atualizar Usuário" }.to change{ User.where(:password_reset_token => collaborator.password_reset_token).first.books.size }.by(1)
      User.where(:password_reset_token => collaborator.password_reset_token).first.books.should include(book)
    end

    it "sees book listed under my books" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => new_collaborator.name
      fill_in "Senha", :with => new_collaborator.password
      fill_in "Confirmação da senha", :with => new_collaborator.password
      click_button "Atualizar Usuário"
      click_link 'Meus Livros'
      page.should have_content(book.title)
    end

    it "keeps inviter as book organizer" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => new_collaborator.name
      fill_in "Senha", :with => new_collaborator.password
      fill_in "Confirmação da senha", :with => new_collaborator.password
      click_button "Atualizar Usuário"
      book.organizer.should eq(organizer)
    end
  end

  context "when it is a new user with invalid token" do
    let(:organizer) { create(:organizer) }
    let(:book) { organizer.organized_books.first }
    let(:email) { Faker::Internet.email }
    let(:new_collaborator) { build(:user) }

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
      fill_in 'user_email', :with => email
      click_button 'Enviar convite'
      collaborator = User.where(:email => email).first
      collaborator.password_reset_sent_at = 5.hours.ago
      collaborator.save!(:validate => false)
    end

    it "visits the URL received by email" do
      # TODO: use actual URL from last_email.body
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      current_path.should eq(edit_book_collaborator_path(book.uuid, collaborator.password_reset_token))
    end

    it "fills in personal info" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => new_collaborator.name
      fill_in "Senha", :with => new_collaborator.password
      fill_in "Confirmação da senha", :with => new_collaborator.password
    end

    it "clicks button" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => new_collaborator.name
      fill_in "Senha", :with => new_collaborator.password
      fill_in "Confirmação da senha", :with => new_collaborator.password
      click_button "Atualizar Usuário"
    end

    it "does not get logged in" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => new_collaborator.name
      fill_in "Senha", :with => new_collaborator.password
      fill_in "Confirmação da senha", :with => new_collaborator.password
      click_button "Atualizar Usuário"
      page.should_not have_content(collaborator.email)
      current_path.should eq(root_path)
    end

    it "shows a notice to user" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => new_collaborator.name
      fill_in "Senha", :with => new_collaborator.password
      fill_in "Confirmação da senha", :with => new_collaborator.password
      click_button "Atualizar Usuário"
      page.should have_content("O link já expirou")
    end

    it "does not get added as collaborator to the book" do
      collaborator = User.where(:email => email).first
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      fill_in "Nome", :with => new_collaborator.name
      fill_in "Senha", :with => new_collaborator.password
      fill_in "Confirmação da senha", :with => new_collaborator.password
      expect{ click_button "Atualizar Usuário" }.not_to change{ User.where(:password_reset_token => collaborator.password_reset_token).first.books.size }
      User.where(:password_reset_token => collaborator.password_reset_token).first.books.should_not include(book)
    end
  end

  context "when it is a registered user" do
    let(:invitation) { create(:invitation) }
    let(:collaborator) { invitation.user }
    let(:book) { invitation.book }
    let(:new_collaborator) { build(:user) }

    it "visits the URL received by email" do
      # TODO: use actual URL from last_email.body
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
    end

    it 'redirects collaborator to app home' do
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      current_path.should eq(app_home_path)
    end

    it "is automatically logged in" do
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      page.should have_content(collaborator.email)
      current_path.should eq(app_home_path)
    end

    it "gets added as collaborator to the book" do
      expect{ visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token) }.to change{ User.where(:password_reset_token => collaborator.password_reset_token).first.books.size }.by(1)
      User.where(:password_reset_token => collaborator.password_reset_token).first.books.should include(book)
    end

    it "sees book listed under my books" do
      visit edit_book_collaborator_path(book.uuid, collaborator.password_reset_token)
      click_link 'Meus Livros'
      page.should have_content(book.title)
    end
  end
end
