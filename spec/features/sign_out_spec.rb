require 'rails_helper'

feature 'User can signs out' do
  given(:user) { create(:user) }

  scenario 'Authenticated user tries to sign out' do
    sign_in(user)

    click_on 'Sign out'
    expect(page).to have_content 'Signed out successfully.'
    expect(current_path).to eq root_path
  end
end