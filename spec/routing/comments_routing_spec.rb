require 'rails_helper'

describe CommentsController, type: :routing do
  describe 'routing' do
    it 'comments resource nested in exercizes' do
      expect(post: '/study_exercizes/1/comments')
        .to route_to 'comments#create', study_exercize_id: '1'
    end
    it 'comments resource nested in questions' do
      expect(post: '/study_questions/1/comments')
        .to route_to 'comments#create', study_question_id: '1'
    end
  end
end
