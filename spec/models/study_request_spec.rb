require 'rails_helper'

RSpec.describe StudyRequest, type: :model do
  let(:study_request) { create :study_request }
  describe 'relations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :study }
  end

  describe 'extensions' do
    it { is_expected.to define_enum_for(:status).with(%i[pending accepted declined]) }
  end

  describe 'callbacks' do
    describe '.create_study_user' do
      context 'when accepted' do
        it 'creates study user' do
          expect(study_request).to receive :create_study_user
          study_request.accepted!
        end
      end
      context 'when declined' do
        it 'should not create study user' do
          expect(study_request).not_to receive :create_study_user
          study_request.declined!
        end
      end
    end
  end
end
