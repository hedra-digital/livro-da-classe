# encoding: utf-8

require 'spec_helper'

describe 'organizer' do
  context 'when he/she has no books' do
    let(:user) { create(:user) }

    before do
      visit root_path
      click_link('Acesse sua conta')
      fill_in 'signin_email', :with => user.email
      fill_in 'signin_password', :with => user.password
      click_button 'Entrar'
    end

    it 'sees message about no books being present' do
      page.should have_content(' Novo livro Informações gerais Textos Originais')
    end
  end
end
