require 'rails_helper'

feature 'Lessons management', type: :feature do
  let(:user) { create :user, :admin }
  before :each do
    sign_in user
  end
  scenario 'Create lessons' do
    visit '/admin/lessons'
    expect(page).to have_content 'Lessons management'
    click_link 'new-lesson'
    fill_in 'Title', with: 'Test it'
    fill_in 'Description', with: 'Some description'
    first('input[type="submit"]').click
    expect(page).to have_content 'Lesson was successfully created'
    expect(page).to have_content 'Test it'
  end

  scenario 'Update lesson' do
    create :lesson
    visit '/admin/lessons'
    first('.edit').click
    fill_in 'Title', with: 'Test it'
    first('input[type="submit"]').click
    expect(page).to have_content 'Test it'
    expect(page).to have_content 'Lesson was successfully updated'
  end

  scenario 'Delete lesson' do
    create :lesson, title: 'Test it'
    visit '/admin/lessons'
    expect(page).to have_content 'Test it'
    first('.delete').click
    expect(page).to have_content 'Lessons management'
    expect(page).not_to have_content 'Test it'
    expect(page).to have_content 'Lesson was successfully destroyed'
  end

  scenario 'Delete lesson with study' do
    lesson = create :lesson, title: 'Test it'
    create :study, lesson: lesson
    visit '/admin/lessons'
    expect(page).to have_content 'Test it'
    first('.delete').click
    expect(page).to have_content 'Lessons management'
    expect(page).not_to have_content 'Test it'
    expect(page).to have_content 'Lesson was successfully destroyed'
  end
end
