require 'rails_helper'

RSpec.describe StudyUserQuestion, type: :model do
  describe 'relations' do
    it { is_expected.to belong_to :study_user }
    it { is_expected.to belong_to :study_question }
  end
end
