require 'rails_helper'

RSpec.describe StudyExercizePolicy do
  let(:study_exercize) { create :study_exercize }
  let(:user) { create :user }
  subject { described_class }
  permissions :show? do
    it { is_expected.to permit user, study_exercize }
  end
end
