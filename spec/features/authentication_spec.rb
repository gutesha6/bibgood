require 'rails_helper'

feature 'Authentication' do
  scenario 'Login via Facebook and logout' do
    lesson = create :lesson
    visit "/lessons/#{lesson.slug}"
    mock_auth_hash
    click_link 'Login'
    click_link 'Sign in with Facebook'
    expect(page).to have_link 'logout'
    expect(page.current_path).to eq "/lessons/#{lesson.slug}"
    click_link 'logout'
    expect(page).to have_link 'Login'
  end
end
