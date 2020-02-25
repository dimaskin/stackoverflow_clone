require 'rails_helper'

feature 'User can create question' do

  given(:user) { create(:user) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
      visit questions_path
      click_on I18n.t(:create, scope: 'questions.form')
    end

    scenario 'Asks a question' do
      fill_in Question.human_attribute_name(:title), with: 'Test question'
      fill_in Question.human_attribute_name(:body),  with: 'Text text text'
      click_on I18n.t(:create, scope: 'questions.form')
      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Test question'
      expect(page).to have_content 'Text text text'
    end

    scenario 'Asks a question with errors' do
      click_on I18n.t(:create, scope: 'questions.form')
      expect(page).to have_content "Заголовок вопроса не может быть пустым"
    end
  end

  scenario 'Unauthenticated user tries to asks a question' do
    visit questions_path
    click_on I18n.t(:create, scope: 'questions.form')
    expect(page).to have_content 'Вам необходимо войти в систему или зарегистрироваться'
  end

end