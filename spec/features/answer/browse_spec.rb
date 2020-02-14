require 'rails_helper'

feature 'All users can view questions and answers' do

  given(:user) {create :user}
  given(:question) {create :question, author: user}
  given!(:answers) { create_list(:answer, 3, question: question, author: user) }

  scenario 'View question with answers' do
    visit question_path(question)

    expect(page).to have_content question.title

    answers.each do |answer|
      expect(page).to have_content answer.body
    end
  end
end