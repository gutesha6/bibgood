require 'rails_helper'

feature 'Exercizes management', type: :feature do
  let!(:lesson) { create :lesson }
  let(:user) { create :user, :admin }
  before :each do
    sign_in user
  end
  scenario 'Create exercize' do
    visit "/admin/lessons/#{lesson.id}"
    expect(page).to have_content 'Exercizes'
    click_link 'Manage exercizes'
    click_link 'new-exercize'
    fill_in 'Body', with: 'Test it'
    fill_in 'Notes', with: 'Some notes'
    first('input[type="submit"]').click
    expect(page).to have_content 'Exercize was successfully created'
    expect(page).to have_content 'Test it'
  end

  scenario 'Update exercize' do
    create :exercize, lesson: lesson
    visit "/admin/lessons/#{lesson.id}"
    click_link 'Manage exercizes'
    first('.edit').click
    fill_in 'Body', with: 'Test it'
    first('input[type="submit"]').click
    expect(page).to have_content 'Test it'
    expect(page).to have_content 'Exercize was successfully updated'
  end

  scenario 'Delete exercize' do
    create :exercize, lesson: lesson, body: 'Test it'
    visit "/admin/lessons/#{lesson.id}"
    click_link 'Manage exercizes'
    expect(page).to have_content 'Test it'
    first('.delete').click
    expect(page).to have_content 'Exercizes'
    expect(page).not_to have_content 'Test it'
    expect(page).to have_content 'Exercize was successfully destroyed'
  end
end
