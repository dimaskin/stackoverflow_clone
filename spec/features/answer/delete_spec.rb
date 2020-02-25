require 'rails_helper'

feature 'Delete answer' do
  
  #have_link

  given(:user) { create :user }
  given(:question_author) { create :user }
  given(:answer_author) { create :user }
  given(:question) { create :question, author: question_author}
  given!(:answer) { create(:answer, author: answer_author, question: question) }

  scenario 'Non author want to delete answer' do
    sign_in(user)
    visit question_path(question)

    expect(page).to have_no_link 'Delete answer'
  end

  scenario "Question's author want to delete answer" do
    sign_in(question_author)
    visit question_path(question)

    expect(page).to have_no_link 'Delete answer'
  end

  scenario 'Author delete answer' do
    sign_in(answer_author)
    visit question_path(question)
    #click_on 'Delete answer'
    click_on I18n.t :delete

    expect(page).to have_no_content(answer.body)
  end

  scenario 'Non authenticated user want delete answer' do
    visit question_path(question)

    expect(page).to have_no_link 'Delete answer'
  end
end