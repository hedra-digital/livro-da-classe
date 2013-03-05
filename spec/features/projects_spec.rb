# encoding: utf-8

require 'spec_helper'

describe 'book organizer' do
  let(:organizer) { create(:organizer) }
  let(:book) { organizer.organized_books.first }
  let(:project) { create(:project) }

  before do
    visit root_path
    click_link('Entrar no site')
    fill_in 'signin_email', :with => organizer.email
    fill_in 'signin_password', :with => organizer.password
    click_button 'Entrar'
    click_link 'Meus Livros'
    click_link book.title
  end

  context "when starting a new project" do
    it 'sees the book info' do
      page.should have_content(book.title)
      page.should have_xpath("//nav[@class='book-nav']")
    end

    it "clicks the new project link" do
      click_link 'Quero fazer o Livro da Classe'
      current_path.should eq(new_book_project_path(book.uuid))
    end

    it "fills out form" do
      click_link 'Quero fazer o Livro da Classe'
      fill_in 'Data de lançamento', :with => project.release_date
      fill_in 'Nome', :with => project.client.name
      fill_in 'Email', :with => project.client.email
      fill_in 'Telefone', :with => project.client.phone
      fill_in 'Cargo', :with => project.client.position
      fill_in 'Instituição de ensino', :with => project.client.company
    end

    it "clicks submit button" do
      click_link 'Quero fazer o Livro da Classe'
      fill_in 'Data de lançamento', :with => project.release_date
      fill_in 'Nome', :with => project.client.name
      fill_in 'Email', :with => project.client.email
      fill_in 'Telefone', :with => project.client.phone
      fill_in 'Cargo', :with => project.client.position
      fill_in 'Instituição de ensino', :with => project.client.company
      click_button 'Criar Projeto'
    end

    it "gets redirected to book page" do
      click_link 'Quero fazer o Livro da Classe'
      fill_in 'Data de lançamento', :with => project.release_date
      fill_in 'Nome', :with => project.client.name
      fill_in 'Email', :with => project.client.email
      fill_in 'Telefone', :with => project.client.phone
      fill_in 'Cargo', :with => project.client.position
      fill_in 'Instituição de ensino', :with => project.client.company
      click_button 'Criar Projeto'
      current_path.should eq(book_path(book.uuid))
    end
  end
end
