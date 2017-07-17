require 'rails_helper'

RSpec.describe Admin::Lesson, type: :model do
  describe 'relations' do
    it do
      is_expected.to have_many(:questions).class_name('Admin::Question')
                                          .dependent(:destroy)
    end
    it do
      is_expected.to have_many(:exercizes).class_name('Admin::Exercize')
                                          .dependent(:destroy)
    end
  end
end
