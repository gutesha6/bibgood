require 'rails_helper'

feature 'Questions management', type: :feature do
  let(:lesson) { create :lesson }
  let(:user) { create :user, :admin }
  before :each do
    sign_in user
  end
  scenario 'Create question' do
    visit "/admin/lessons/#{lesson.id}"
    expect(page).to have_content 'Questions'
    click_link 'Manage question'
    click_link 'new-question'
    fill_in 'Body', with: 'Test it'
    fill_in 'Notes', with: 'Some notes'
    first('input[type="submit"]').click
    expect(page).to have_content 'Question was successfully created'
    expect(page).to have_content 'Test it'
  end

  scenario 'Update question' do
    create :question, lesson: lesson
    visit "/admin/lessons/#{lesson.id}"
    click_link 'Manage question'
    first('.edit').click
    fill_in 'Body', with: 'Test it'
    first('input[type="submit"]').click
    expect(page).to have_content 'Test it'
    expect(page).to have_content 'Question was successfully updated'
  end

  scenario 'Delete question' do
    create :question, lesson: lesson, body: 'Test it'
    visit "/admin/lessons/#{lesson.id}"
    click_link 'Manage question'
    expect(page).to have_content 'Test it'
    first('.delete').click
    expect(page).to have_content 'Questions'
    expect(page).not_to have_content 'Test it'
    expect(page).to have_content 'Question was successfully destroyed'
  end
end
