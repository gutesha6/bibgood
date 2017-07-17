require 'rails_helper'

RSpec.feature 'Comments', type: :feature do
  let(:study) { create :study, :started }
  let(:user) { study.user }
  before(:each) { sign_in user }

  scenario 'Comment study exercize', js: true do
    create_list :study_exercize, 2, study: study
    visit "/studies/#{study.to_param}"
    first(:link_or_button, 'Start').click
    expect(page).not_to have_button 'Start'
    within 'section.exercizes' do
      first('input[type="text"]').set '*mega* comment'
      click_button 'Send'
    end
    expect(first('.author').text)
      .to include user.name
    expect(first('.comment')['innerHTML'])
      .to include '<em>mega</em> comment'
    expect(page).not_to have_button 'Start'
  end

  scenario 'Reply to other user comment on exercize', js: true do
    exercize = create :study_exercize, study: study
    create :comment, commentable: exercize
    visit "/studies/#{study.to_param}"
    click_on 'Reply'
    within 'section.exercizes' do
      first('input[type="text"]').set '*mega* comment'
      click_button 'Send'
    end
    expect(all('.author')[-1].text)
      .to include user.name
    expect(all('.comment')[-1]['innerHTML'])
      .to include '<em>mega</em> comment'
  end

  scenario 'Comment study question', js: true do
    create :study_question, study: study
    visit "/studies/#{study.to_param}"
    within 'section.questions' do
      first('input[type="text"]').set '*mega* comment'
      click_button 'Send'
    end
    expect(first('.author').text)
      .to include user.name
    expect(first('.comment')['innerHTML'])
      .to include '<em>mega</em> comment'
  end
end
