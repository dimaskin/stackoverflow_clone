require 'rails_helper'

feature 'Create answer for question' do

  given(:user) { create :user }
  given(:non_author) { create :user }
  given(:question) { create :question, author: user}
  given(:answer_body) { attributes_for(:answer)[:body] }

  describe 'Authenticated user' do
    scenario 'can create answer' do
      sign_in(user)
      visit question_path(question)
      fill_in Answer.human_attribute_name(:body), with: answer_body
      click_on I18n.t(:create, scope: 'answers.form')

      #expect(page).to have_content 'Your answer successfully created'
      expect(page).to have_content Answer.human_attribute_name(:body)
    end

    scenario 'user tries to create a invalid answer' do
      sign_in(user)
      visit question_path(question)
      click_on I18n.t(:create, scope: 'answers.form')
      expect(page).to have_content "Ваш ответ не может быть пустым"
      #expect(page).to have_content `#{Answer.human_attribute_name(:body)} #{I18n.t('activerecord.errors.messages.blank')}`
    end
  end

  scenario 'Non-authenticated user ties user create answer' do
    visit question_path(question)
    expect(page).to have_content I18n.t(:authentication_required, scope: 'answers.form')
  end
end