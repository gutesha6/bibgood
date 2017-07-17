require 'rails_helper'

RSpec.feature 'Join study', type: :feature do
  let(:study) { create :study }
  let(:mentor) { study.user }
  let(:user) { create :user }
  before(:each) { sign_in user }
  scenario 'join study via request' do
    visit "/studies/#{study.to_param}"
    click_link 'Request place'
    fill_in 'Title', with: 'Take me'
    fill_in 'Body', with: 'really *really* want to'
    click_button 'Request place'
    expect(page).to have_content 'Study request was successfully created'
    click_link 'Back'
    expect(page).to have_content 'Pending'
    visit "/studies/#{study.to_param}"
    expect(find('main')).not_to have_content user.name
    StudyRequest.last.accepted!
    # visit "/studies/#{study.to_param}"
    # expect(find('main')).to have_content user.name
  end

  scenario 'join study via token' do
    visit "/studies/#{study.to_param}?token=#{study.token}"
    click_button 'Participate'
    expect(page).to have_content user.name
  end
end
