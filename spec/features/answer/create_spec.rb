require 'rails_helper'

feature 'Create answer for question' do

  given(:user) { create :user }
  given(:non_author) { create :user }
  given(:question) { create :question, author: user}

  describe 'Authenticated user' do
    scenario 'can create answer' do
      sign_in(user)
      visit question_path(question)
      fill_in 'Your answer', with: 'text text text'
      click_on 'Answer'

      expect(page).to have_content 'Your answer successfully created'
      expect(page).to have_content 'text text text'
    end

    scenario 'non-author tries to create a answer' do
      sign_in(non_author)
      visit question_path(question)
      fill_in 'Your answer', with: 'text text text'
      click_on 'Answer'

      expect(page).to have_content 'Your answer successfully created'
      expect(page).to have_content 'text text text'
    end

    scenario 'user tries to create a invalid answer' do
      sign_in(user)
      visit question_path(question)
      click_on 'Answer'
      expect(page).to have_content "Body can't be blank"
    end
  end

  scenario 'Non-authenticated user ties user create answer' do
    visit question_path(question)
    click_on 'Answer'
    expect(page).to have_content "You need to sign in or sign up before continuing."
  end
end