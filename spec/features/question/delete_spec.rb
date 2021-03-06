require 'rails_helper'

feature 'Delete questions. ' do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, author: user) }

  describe 'Authenticated user' do

    scenario 'can delete your own question' do
      sign_in(user)
      visit question_path(question)
      #byebug
      click_on I18n.t(:delete)
      expect(page).to have_no_content(question.title)
    end

    scenario "can't delete another author's questions"  do
      sign_in(another_user)
      visit question_path(question)
      expect(page).to have_no_content(I18n.t(:delete))
    end

  end

  scenario "Unauthenticated user can't delete any questions" do
    visit question_path(question)
    expect(page).to have_no_content(I18n.t(:delete))
end

end