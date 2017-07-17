require 'rails_helper'

RSpec.describe Exercize, type: :model do
  let(:exercize) { create :exercize }
  describe 'relations' do
    it { is_expected.to belong_to :lesson }
    it { is_expected.to have_many :study_exercizes }
  end
  describe 'validations' do
    it { is_expected.to validate_presence_of :body }
  end
  describe 'extensions' do
    it { is_expected.to be_versioned }
  end
end
