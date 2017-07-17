require 'rails_helper'

RSpec.describe StudyUserExercize, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to(:study_user) }
    it { is_expected.to belong_to :study_exercize }
    it do
      is_expected.to have_many(:transitions)
        .class_name('StudyUserExercizeTransition')
    end
  end

  describe 'extensions' do
    it { is_expected.to delegate_method(:study).to :study_user }
  end

  describe 'validations' do
    describe '.user_participate_in_study' do
      let(:study) { create :study, :with_exercizes }
      context 'when participant' do
        let(:study_user_exercize) do
          StudyUserExercize.new study_exercize: study.exercizes.first,
                                study_user: create(:study_user, study: study)
        end
        it 'is saved' do
          expect { study_user_exercize.save! }.not_to raise_exception
        end
      end
      context 'when not participant' do
        let(:study_user_exercize) do
          StudyUserExercize.new study_exercize: study.exercizes.first,
                                study_user: create(:study_user)
        end
        it 'raises error' do
          study_user_exercize.save
          expect(study_user_exercize.errors).to include(:study_user_id)
        end
      end
    end
  end

  describe '.adjacent_exercizes' do
    let(:study) { create :study, :with_exercizes, exercizes_count: 3 }
    let(:study_user) { create :study_user, study: study }
    let!(:study_user_exercize) do
      described_class.new study_exercize: study.exercizes.first,
                          study_user: study_user
    end
    subject { study_user_exercize.adjacent_exercizes }
    context 'when adjacent exercize exist' do
      let!(:adjacent_exercize) do
        described_class.create study_exercize: study.exercizes.last,
                               study_user: study_user
      end
      it { is_expected.to eq [adjacent_exercize] }
    end
    context 'when no adjacent exercizes' do
      it { is_expected.to eq [] }
    end
  end
end
