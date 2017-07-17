require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:question) { create :question }
  describe 'relations' do
    it { is_expected.to belong_to :lesson }
    it { is_expected.to have_many :study_questions }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
  end

  describe 'extensions' do
    it { is_expected.to be_versioned }
  end
end
