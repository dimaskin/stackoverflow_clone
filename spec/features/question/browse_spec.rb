require 'rails_helper'

feature 'User can browse all question' do

  given!(:user) {create :user}
  given!(:user1) {create :user}
  given!(:questions) {create_list :question, 5,  author: user}

  describe 'Authenticated user' do
    scenario 'Can views all questions' do
      sign_in(user1)
      visit questions_path

      questions.each do |question|
        expect(page).to have_content(question.title)
      end

    end

  end

  scenario 'Unauthenticated user can views all questions' do
    visit questions_path

    questions.each do |question|
      expect(page).to have_content(question.title)
    end
  end

end