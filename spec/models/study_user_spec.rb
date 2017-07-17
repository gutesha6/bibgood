require 'rails_helper'

RSpec.describe StudyUser, type: :model do
  let(:study) { create :study }
  describe 'relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :study }
    it { is_expected.to have_many(:study_user_exercizes) }
  end
  describe 'validations' do
    describe 'user and study are unique' do
      let!(:study_user) { create :study_user }
      it 'raises error' do
        su = StudyUser.create study: study_user.study, user: study_user.user
        expect(su.errors).to include :user_id
      end
    end
  end
  describe 'callbacks' do
    it { is_expected.to callback(:start_study).after(:create) }
    it 'transition study to started when enough users participate' do
      create_list :study_user, Study::MIN_USERS - 1, study: study
      expect(study.current_state).to eq 'started'
    end
  end
end
