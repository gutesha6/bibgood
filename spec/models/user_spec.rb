require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }
  describe 'relations' do
    it do
      is_expected.to have_many(:authored_studies)
        .dependent(:destroy).class_name('Study')
    end
    it { is_expected.to have_many(:study_users).dependent(:destroy) }
    it { is_expected.to have_many(:studies).through(:study_users) }
    it { is_expected.to have_many(:study_exercizes).through(:studies) }
    it { is_expected.to have_many(:friendships) }
    it { is_expected.to have_many(:friends).through(:friendships) }
    it do
      is_expected.to have_many(:inverse_friendships)
        .class_name('Friendship')
        .with_foreign_key('friend_id')
    end
    it do
      is_expected.to have_many(:inverse_friends).through(:inverse_friendships)
                                                .source(:user)
    end
    it { is_expected.to have_many :study_requests }
    it { is_expected.to have_many :comments }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }
  end

  describe '#from_omniauth' do
    let(:auth_hash) do
      JSON.parse fixture_file('omniauth_facebook.json')
    end
    let(:auth) { OmniAuth::AuthHash.new auth_hash }
    let(:user) { User.last }

    subject { User.from_omniauth auth }

    context 'when new user' do
      it 'creates user' do
        expect { subject }.to change(User, :count).by(1)
      end
    end

    it 'set name for user' do
      subject
      expect(user.name).to eq auth_hash['info']['name']
    end

    it 'sets email for user' do
      subject
      expect(user.email).to eq auth_hash['info']['email']
    end

    it 'sets avatar url' do
      subject
      expect(user.avatar_url).to eq auth_hash['info']['image']
    end
  end

  describe '.study_user' do
    let(:study_user) { create :study_user, user: user }
    let(:study) { study_user.study }
    it 'returns StudyUser' do
      expect(user.study_user(study)).to eq study_user
    end
  end

  describe '.study_user_exercize' do
    context 'when user does not participate in study' do
    end
    context 'when user participate in study' do
    end
  end
end
