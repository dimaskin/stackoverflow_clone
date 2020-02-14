require 'rails_helper'

feature 'User can create question' do

  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit questions_path
      click_on 'Ask question'
    end

    scenario 'Asks a question' do
      fill_in 'Title', with: 'Test question'
      fill_in 'Body', with: 'Text text text'
      click_on 'Ask'
      expect(page).to have_content 'Your question succefully created.'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'Text text text'
    end

    scenario 'Asks a question with errors' do
      click_on 'Ask'
      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'Unauthenticated user tries to asks a question' do
    visit questions_path
    click_on 'Ask question'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end