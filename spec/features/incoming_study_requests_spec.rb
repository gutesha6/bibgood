require 'rails_helper'

RSpec.feature 'Incoming Study Requests', type: :feature do
  let(:mentor) { create :user }
  let(:study) { create :study, user: mentor }
  let(:user) { create :user }
  before :each do
    sign_in mentor
  end
  scenario 'approve incoming study request' do
    create :study_request, user: user, study: study
    visit '/incoming_study_requests'
    expect(page).to have_content user.name
    first('.edit').click
    expect(find('#incoming_study_request_status').value).to eq 'pending'
    select 'Accepted', from: 'incoming_study_request_status'
    click_button 'Respond to request'
    # visit "/studies/#{study.to_param}"
    # expect(page).to have_content user.name
  end
  scenario 'decline incoming study request' do
    create :study_request, user: user, study: study
    visit '/incoming_study_requests'
    expect(page).to have_content user.name
    first('.edit').click
    expect(find('#incoming_study_request_status').value).to eq 'pending'
    select 'Declined', from: 'incoming_study_request_status'
    click_button 'Respond to request'
    visit "/studies/#{study.to_param}"
    expect(page).not_to have_content user.name
  end
  scenario 'change mind about study request' do
    create :study_request, user: user, study: study
    visit '/incoming_study_requests'
    expect(page).to have_content user.name
    first('.edit').click
    expect(find('#incoming_study_request_status').value).to eq 'pending'
    select 'Declined', from: 'incoming_study_request_status'
    click_button 'Respond to request'
    visit "/studies/#{study.to_param}"
    expect(page).not_to have_content user.name
    visit '/incoming_study_requests'
    expect(page).to have_content user.name
    first('.edit').click
    expect(find('#incoming_study_request_status').value).to eq 'declined'
    select 'Accepted', from: 'incoming_study_request_status'
    click_button 'Respond to request'
    # visit "/studies/#{study.to_param}"
    # expect(page).to have_content user.name
  end
end
