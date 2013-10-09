# encoding: utf-8

require 'spec_helper'

# TODO: can't create project as collaborator

describe 'book organizer' do
  let(:organizer) { create(:organizer) }
  let(:book) { organizer.organized_books.first }
  let(:project_attributes) { attributes_for(:project) }

  context "when starting a new project" do
    before do
      visit root_path
      click_link('Entrar no site')
      fill_in 'signin_email', :with => organizer.email
      fill_in 'signin_password', :with => organizer.password
      click_button 'Entrar'
      click_link 'Meus livros'
      click_link book.title
    end

    it 'sees the book info' do
      page.should have_content(book.title)
      page.should have_xpath("//div[@id='book-info']")
    end

    it "clicks the new project link" do
      click_link 'Contratar'
      current_path.should eq(edit_book_project_path(book.uuid))
    end

    it "fills out form" do
      click_link 'Publicar'
      fill_in 'project_release_date', :with => project_attributes[:release_date]
      fill_in 'Nome', :with => organizer.name
      fill_in 'Email', :with => organizer.email
      fill_in 'Telefone', :with => "MyString"
      select('Professor', :from => 'Cargo')
      fill_in 'Instituição de ensino', :with => "MyString"
      check 'project_terms_of_service'
    end

    it "clicks submit button" do
      click_link 'Publicar'
      fill_in 'project_release_date', :with => project_attributes[:release_date]
      fill_in 'Nome', :with => organizer.name
      fill_in 'Email', :with => organizer.email
      fill_in 'Telefone', :with => "MyString"
      select('Professor', :from => 'Cargo')
      fill_in 'Instituição de ensino', :with => "MyString"
      check 'project_terms_of_service'
      click_button 'Criar Projeto'
    end

    it "creates new project" do
      click_link 'Publicar'
      fill_in 'project_release_date', :with => project_attributes[:release_date]
      fill_in 'Nome', :with => organizer.name
      fill_in 'Email', :with => organizer.email
      fill_in 'Telefone', :with => "MyString"
      select('Professor', :from => 'Cargo')
      fill_in 'Instituição de ensino', :with => "MyString"
      check 'project_terms_of_service'
      expect { click_button 'Criar Projeto' }.to change { Project.all.size }.by(1)
    end

    it "gets redirected to book page" do
      click_link 'Publicar'
      fill_in 'project_release_date', :with => project_attributes[:release_date]
      fill_in 'Nome', :with => organizer.name
      fill_in 'Email', :with => organizer.email
      fill_in 'Telefone', :with => "MyString"
      select('Professor', :from => 'Cargo')
      fill_in 'Instituição de ensino', :with => "MyString"
      check 'project_terms_of_service'
      click_button 'Criar Projeto'
      current_path.should eq(book_path(book.uuid))
    end
  end

  # context "when working on a current project" do
  #   let(:client) { create(:client, :user_id => organizer.id, :name => organizer.name, :email => organizer.email) }
  #   let(:project) { create(:project, :client_id => client.id, :book_id => book.id) }

  #   before do
  #     visit root_path
  #     click_link('Entrar no site')
  #     fill_in 'signin_email', :with => organizer.email
  #     fill_in 'signin_password', :with => organizer.password
  #     click_button 'Entrar'
  #     click_link book.title
  #   end

  #   it 'sees the book info' do
  #     within("#book-info") do
  #       page.should have_content(book.title)
  #     end
  #   end

  #   it "does not see the new project link" do
  #     page.should_not have_link('Publicar')
  #   end

  # end

end
