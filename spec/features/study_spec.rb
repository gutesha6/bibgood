require 'rails_helper'

feature 'Study' do
  let(:user) { create :user }
  let!(:lesson) { create :lesson }
  let(:friend) { create :user }
  let(:running_study) { create :study, :started, user: user }
  before :each do
    user.friends << friend
    sign_in user
  end
  scenario 'Create new study' do
    visit "/lessons/#{lesson.to_param}"
    click_link 'Setup study'
    expect(page).to have_content "Invite \"#{lesson.title}\" Study Users"
    expect(page).to have_content friend.name
    click_button 'Add to study'
    expect(page).to have_content 'Study  Users'
    expect(page).to have_content 'Study user was successfully created'
    expect(page).to have_content friend.name
    visit '/lessons'
    within "##{lesson.slug}" do
      click_link 'Continue'
    end
    expect(page).to have_link 'Invite'
    visit "/lessons/#{lesson.to_param}"
    expect(page).not_to have_link 'Setup study'
    concurrent_lesson = create :lesson
    visit "/lessons/#{concurrent_lesson.to_param}"
    expect(page).to have_link 'Setup study'
  end
  scenario 'Complete study' do
    visit "/studies/#{running_study.to_param}"
    click_button 'Complete'
    expect(page.current_path).to eq "/studies/#{running_study.to_param}"
    expect(page).to have_content 'Completed'
  end
end
