require 'rails_helper'

RSpec.describe StudyExercize, type: :model do
  let(:study_exercize) { create :study_exercize }

  describe 'relations' do
    it { is_expected.to belong_to(:study).inverse_of(:exercizes) }
    it { is_expected.to belong_to(:exercize) }
    it { is_expected.to have_many :comments }
    it { is_expected.to belong_to(:exercize_version) }
    it { is_expected.to have_many(:study_user_exercizes) }
    it { is_expected.to have_many(:study_users).through(:study_user_exercizes) }
    it { is_expected.to have_many(:users).through(:study_users) }
  end

  describe 'extensions' do
    it { is_expected.to delegate_method(:body).to :exercize }
    it { is_expected.to delegate_method(:notes).to :exercize }
  end

  describe '.exercize', versioning: true do
    subject { study_exercize.reload.exercize }
    context 'when associated exercize exist' do
      it { is_expected.to be_a Exercize }
    end
    context 'when associated with version' do
      let(:exercize) { study_exercize.exercize }
      before(:each) { exercize.destroy }

      it { is_expected.to be_a Exercize }
      it { is_expected.to be_new_record }
    end
  end

  describe '.started?' do
    let(:study) { create :study, :with_exercizes, :started }
    let(:study_user) { study.study_users.first }
    let(:study_exercize) { study.exercizes.first }
    let(:user) { study_user.user }
    subject { study_exercize.started?(user) }
    context 'when started exercize' do
      let!(:study_user_exercize) do
        StudyUserExercize.create study_exercize: study_exercize,
                                 study_user: study_user
      end
      it { is_expected.to be_truthy }
    end
    context 'when new exercize' do
      it { is_expected.to be_falsey }
    end
  end
end
