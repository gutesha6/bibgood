# Preview all emails at http://localhost:3000/rails/mailers/study
class StudyPreview < ActionMailer::Preview
  def user_joined
    StudyMailer.user_joined(Study.first, User.first)
  end
end
